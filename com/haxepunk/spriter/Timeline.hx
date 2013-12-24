package com.haxepunk.spriter;

enum ObjectType
{
	SPRITE;
	BONE;
	BOX;
	POINT;
	SOUND;
	ENTITY;
	VARIABLE;
}

class Timeline
{
	public var id : Int;
	public var name : String;
	public var objectType : ObjectType;
	public var keys : Array<TimelineKey>; // <key> tags within <timeline> tags
	
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		keys = new Array<TimelineKey>();
		
		id = Std.parseInt(fast.att.id);
		name = fast.att.name;
		objectType = fast.has.objectType ? Type.createEnum(ObjectType, fast.att.objectType.toUpperCase()) : ObjectType.SPRITE;
		
		for (k in fast.nodes.key)
		{
			keys.push(new TimelineKey(parent, k));
		}
	}
}
