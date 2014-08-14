package com.haxepunk.spriter;

import flash.display.BitmapData;
import openfl.Assets;
import flash.geom.Point;

class Scml extends Graphic
{
	public function new (name:String, x:Float = 0, y:Float = 0)
	{
		super();
		this.x = x;
		this.y = y;		
		#if (flash || js) blit = true; #end
		
		var source:Xml = Xml.parse(Assets.getText(name));
		
		active = true;
		
		_folders = new Array<Folder>();
		_entities = new Array<ScmlEntity>();
		activeCharacterMap = new Array<Folder>();
		
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
	
	var renderX:Float = 0;
	var renderY:Float = 0;
	
	public function characterInfo () : SpatialInfo
	{
		return new SpatialInfo(renderX + x, renderY + y, angle, scaleX, scaleY, alpha, spin);
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
	
	public override function render (target:BitmapData, point:Point, camera:Point)
	{	
		renderAtlas(0, point, camera);
	}
		
	public override function renderAtlas (layer:Int, point:Point, camera:Point)
	{
		// determine drawing location
		//_point.x = point.x + x - camera.x * scrollX;
		//_point.y = point.y + y - camera.y * scrollY;
		
		var currentEnt = _entities[_currentEntity];
		var currentAnim = currentEnt.animations[_currentAnimation];

		//Doesn't work. Hmm...
		//renderX = point.x;
		//renderY = point.y;
		currentAnim.render(point, camera);
	}
	
	override public function update() 
	{
		var currentEnt = _entities[_currentEntity];
		var currentAnim = currentEnt.animations[_currentAnimation];
		currentAnim.currentTime += cast(HXP.elapsed * 1000, Int);
	}
	
	public var angle : Float = 0;
	public var scaleX : Float = 1;
	public var scaleY : Float = 1;
	public var alpha : Float = 1;
	public var spin : Int = 1;
}
