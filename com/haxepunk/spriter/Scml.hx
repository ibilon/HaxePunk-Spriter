package com.haxepunk.spriter;

class Scml
{
	public function new (parent:Spriter, name:String, source:Xml)
	{
		_folders = new Array<Folder>();
		_entities = new Array<ScmlEntity>();
		activeCharacterMap = new Array<Folder>();
		
		_parent = parent;
		
		var fast = new haxe.xml.Fast(source.firstElement());
		
		if (fast.att.scml_version != "1.0")
			trace("Warning, HaxePunk-Spriter may not be compatible with the scml version used in the file.");
			
		var folder = name.substr(0, name.lastIndexOf("/")+1);
		
		for (f in fast.nodes.folder)
		{
			_folders.push(new Folder(folder, f));
		}
		
		for (e in fast.nodes.entity)
		{
			_entities.push(new ScmlEntity(this, e));
		}
		
		activeCharacterMap = _folders;
	}
	
	public var currentTime(get_currentTime, set_currentTime) : Int;
	public inline function get_currentTime () : Int
	{
		var currentEnt = _entities[_currentEntity];
		var currentAnim = currentEnt.animations[_currentAnimation];
		return currentAnim.currentTime;
	}
	public inline function set_currentTime (value:Int) : Int
	{
		var currentEnt = _entities[_currentEntity];
		var currentAnim = currentEnt.animations[_currentAnimation];
		return currentAnim.currentTime = value;
	}
	
	public function characterInfo () : SpatialInfo
	{
		return new SpatialInfo(_parent.x, _parent.y, _parent.angle, _parent.scaleX, _parent.scaleY, _parent.alpha, _parent.spin);
	}
	
	public function applyCharacterMap (charMap:CharacterMap, reset:Bool)
	{
		if (reset)
		{
			activeCharacterMap = _folders;
		}
		
		for (currentMap in charMap.maps)
		{
			if (currentMap.targetFolder >-1 && currentMap.targetFile >-1)
			{
				var targetFolder = activeCharacterMap[currentMap.targetFolder];
				var targetFile = targetFolder.files[currentMap.targetFile];
				
				activeCharacterMap[currentMap.targetFolder].files[currentMap.targetFile] = targetFile;
			}
		}
	}
	
	public function playAnim(animName:String):Void
	{
		var currentEnt = _entities[_currentEntity];
		var currentAnim:Animation ;
		for (currentAnim in currentEnt.animations)
		{
			if (currentAnim.name == animName)
			{
				_currentAnimation = currentAnim.id;
				currentAnim.currentTime = 0;
				break;
			}
		}
	}
	
	public var activeCharacterMap : Array<Folder>;
	public var smooth : Bool = true;
	
	private var _currentEntity : Int = 0;
	private var _currentAnimation : Int = 0;
	private var _folders : Array<Folder>; // <folder> tags
	private var _entities : Array<ScmlEntity>; // <entity> tags
	private var _parent : Spriter;
}
