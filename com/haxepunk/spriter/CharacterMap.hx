package com.haxepunk.spriter;

class CharacterMap
{
	public var id : Int;
	public var name : String;
	public var maps : Array<Map>; // <map> tags
	
	public function new (fast:haxe.xml.Fast)
	{
		maps = new Array<Map>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.att.name;
		
		for (m in fast.nodes.map)
		{
			maps.push(new Map(m));
		}
	}
}
