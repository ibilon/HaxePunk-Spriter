package com.haxepunk.spriter;

class BoneTimelineKey extends SpatialTimelineKey
{
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		super(parent, fast);
	}
	
	public override function linear (keyB:TimelineKey, t:Float) : TimelineKey
	{
		if (!Std.is(keyB, BoneTimelineKey))
			throw "Error should be a BoneTimelineKey";
			
		var keyB_btk = cast(keyB, BoneTimelineKey);
		
		var returnKey : BoneTimelineKey = this;
		returnKey.info = SpatialInfo.linear(info, keyB_btk.info, info.spin, t);
		return returnKey;
	}
	
	public var length : Int = 200;
	public var width : Int = 10;
}
