package com.haxepunk.spriter;

class Bone
{
	public var x : Float;
	public var y : Float;
	public var angle : Float;
	public var scale_x : Float;
	public var scale_y : Float;
	public var a : Float;
	
	public function new (fast:haxe.xml.Fast)
	{
		x = fast.has.x ? Std.parseFloat(fast.att.x) : 0;
		y = fast.has.y ? Std.parseFloat(fast.att.y) : 0;
		angle = fast.has.angle ? Std.parseFloat(fast.att.angle) : 0;
		scale_x = fast.has.scale_x ? Std.parseFloat(fast.att.scale_x) : 1;
		scale_y = fast.has.scale_y ? Std.parseFloat(fast.att.scale_y) : 1;
		a = fast.has.a ? Std.parseFloat(fast.att.a) : 1;
	}
}
