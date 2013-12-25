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
		name = fast.has.name ? fast.att.name : "";
		objectType = fast.has.object_type ? Type.createEnum(ObjectType, fast.att.object_type.toUpperCase()) : ObjectType.SPRITE;
		
		for (k in fast.nodes.key)
		{			
			switch (objectType)
			{
				case ObjectType.SPRITE:					
					keys.push(new SpriteTimelineKey(parent, k));
					
				case ObjectType.BONE:
					keys.push(new BoneTimelineKey(parent, k));
					
				default:
					
			}
		}
	}
}
