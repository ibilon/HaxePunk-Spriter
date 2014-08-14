package com.haxepunk.spriter;

import com.haxepunk.Entity;
import flash.display.BitmapData;
import openfl.Assets;
import flash.geom.Point;

class Scml extends Graphic
{
	public var angle : Float = 0;
	public var scaleX : Float = 1;
	public var scaleY : Float = 1;
	public var alpha : Float = 1;
	public var spin : Int = 1;
	public var activeCharacterMap : Array<Folder>;
	public var smooth : Bool = true;
	
	private var _currentEntity : ScmlEntity = null;
	private var _currentAnimation : Animation = null;
	private var _folders : Array<Folder>; // <folder> tags
	private var _entities : Array<ScmlEntity>; // <entity> tags
	
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
		
		_currentEntity = _entities[0];
		_currentAnimation = _currentEntity.animations[0];
	}
	
	public function characterInfo () : SpatialInfo
	{
		return new SpatialInfo(0, 0, angle, scaleX, scaleY, alpha, spin);
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
		if (_currentAnimation.name != animName)
		{		
			var currentAnim:Animation;
			for (currentAnim in _currentEntity.animations)
			{
				if (currentAnim.name == animName)
				{
					_currentAnimation = currentAnim;
					currentAnim.currentTime = 0;
					break;
				}
			}
		}
	}
	
	public override function render (target:BitmapData, point:Point, camera:Point)
	{	
		renderAtlas(0, point, camera);
	}
		
	public override function renderAtlas (layer:Int, point:Point, camera:Point)
	{	
		point.x += x;
		point.y += y;
		
		_currentAnimation.render(point, camera);
	}
	
	override public function update() 
	{
		_currentAnimation.currentTime += cast(HXP.elapsed * 1000, Int);
	}
}
