package com.haxepunk.spriter;

enum CurveType
{
	INSTANT;
	LINEAR;
	QUADRATIC;
	CUBIC;
}

class TimelineKey
{
	public var id : Int;
    public var time : Int;
    public var curveType : CurveType;
    public var c1 : Float;
    public var c2 : Float;
    public var bones : Array<Bone>; // <bone> tags
    public var objects : Array<Object>; // <object> tags
	
	public function new (fast:haxe.xml.Fast)
	{
		bones = new Array<Bone>();
		objects = new Array<Object>();
		
		id = Std.parseInt(fast.att.id);
		time = fast.has.time ? Std.parseInt(fast.att.time) : 0;
		curveType = fast.has.curveType ? Type.createEnumIndex(CurveType, Std.parseInt(fast.att.curveType)) : CurveType.LINEAR;
		c1 = fast.has.c1 ? Std.parseFloat(fast.att.c1) : 0;
		c2 = fast.has.c2 ? Std.parseFloat(fast.att.c2) : 0;
		
		for (b in fast.nodes.bone)
		{
			bones.push(new Bone(b));
		}
		
		for (o in fast.nodes.object)
		{
			objects.push(new Object(o));
		}
	}
}
