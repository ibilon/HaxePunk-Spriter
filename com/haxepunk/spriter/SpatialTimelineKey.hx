package com.haxepunk.spriter;

class SpatialTimelineKey extends TimelineKey
{
	public function new (parent:Scml, fast:haxe.xml.Fast)
	{
		super(parent, fast);
		
		var x = fast.has.x ? Std.parseFloat(fast.att.x) : 0;
		var y = fast.has.y ? Std.parseFloat(fast.att.y) : 0;
		var angle = fast.has.angle ? Std.parseFloat(fast.att.angle) : 0;
		var scale_x = fast.has.scale_x ? Std.parseFloat(fast.att.scale_x) : 1;
		var scale_y = fast.has.scale_y ? Std.parseFloat(fast.att.scale_y) : 1;
		var alpha = fast.has.a ? Std.parseFloat(fast.att.a) : 1;
		
		info = new SpatialInfo(x, y, angle, scale_x, scale_y, alpha);
	}
	
	public var info : SpatialInfo;
}
