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
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		bones = new Array<BoneTimelineKey>();
		objects = new Array<SpriteTimelineKey>();
		
		id = fast.has.id ? Std.parseInt(fast.att.id) : 0;
		time = fast.has.time ? Std.parseInt(fast.att.time) : 0;
		curveType = fast.has.curveType ? Type.createEnumIndex(CurveType, Std.parseInt(fast.att.curveType)) : CurveType.LINEAR;
		c1 = fast.has.c1 ? Std.parseFloat(fast.att.c1) : 0;
		c2 = fast.has.c2 ? Std.parseFloat(fast.att.c2) : 0;
		
		for (b in fast.nodes.bone)
		{
			bones.push(new BoneTimelineKey(parent, b));
		}
		
		for (o in fast.nodes.object)
		{
			objects.push(new SpriteTimelineKey(parent, o));
		}
	}
	
	public var id : Int;
	public var time : Int;
	public var curveType : CurveType;
	public var c1 : Float;
	public var c2 : Float;
	public var bones : Array<BoneTimelineKey>; // <bone> tags
	public var objects : Array<SpriteTimelineKey>; // <object> tags
	
	public function interpolate (nextKey:TimelineKey, nextKeyTime:Int, currentTime:Float) : TimelineKey
	{
		return linear(nextKey, getTWithNextKey(nextKey, nextKeyTime, currentTime));
	}
	
	public function getTWithNextKey(nextKey:TimelineKey, nextKeyTime:Int, currentTime:Float) : Float
	{
		if (curveType == CurveType.INSTANT || time == nextKey.time)
		{
			return 0;
		}
		
		var t = (currentTime-time) / (nextKey.time-time);
		
		if (curveType == CurveType.LINEAR)
		{
			return t;        
		}
		else if (curveType == CurveType.QUADRATIC)
		{
			return Utils.quadratic(0.0, c1, 1.0, t);
		}
		else if (curveType == CurveType.CUBIC)
		{  
			return Utils.cubic(0.0, c1, c2, 1.0, t);
		}
	
		return 0; // Runtime should never reach here
	}
	
	public function linear (keyB : TimelineKey, t) : TimelineKey
	{
		// overridden in inherited types  return linear(this,keyB,t);
		
		if (bones.length == 1)
		{
			return bones[0].linear(keyB, t);
		}
		if (objects.length == 1)
		{
			return objects[0].linear(keyB, t);
		}
		
		trace("noooo");
		return null; // ?
	}
}
