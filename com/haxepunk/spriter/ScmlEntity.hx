package com.haxepunk.spriter;

class ScmlEntity
{
	public var id : Int;
	public var name : String;
	public var characterMaps : Array<CharacterMap>; // <character_map> tags
	public var animations : Array<Animation>; // <animation> tags
	
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		characterMaps = new Array<CharacterMap>();
		animations = new Array<Animation>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.att.name;
		
		for (cm in fast.nodes.character_map)
		{
			characterMaps.push(new CharacterMap(cm));
		}
		
		for (a in fast.nodes.animation)
		{
			animations.push(new Animation(parent, a));
		}
	}
}
