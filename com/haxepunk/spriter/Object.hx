package com.haxepunk.spriter;

class Object
{
	public var folder : Int;
	public var file : Int;
	public var x : Float;
	public var y : Float;
	public var angle : Float;
	public var scale_x : Float;
	public var scale_y : Float;
	public var pivot_x : Float;
	public var pivot_y : Float;
	public var a : Float;
	
	public function new (fast:haxe.xml.Fast)
	{
		folder = fast.has.folder ? Std.parseInt(fast.att.folder) : 0;
		file = fast.has.file ? Std.parseInt(fast.att.file) : 0;
		x = fast.has.x ? Std.parseFloat(fast.att.x) : 0;
		y = fast.has.y ? Std.parseFloat(fast.att.y) : 0;
		angle = fast.has.angle ? Std.parseFloat(fast.att.angle) : 0;
		scale_x = fast.has.scale_x ? Std.parseFloat(fast.att.scale_x) : 1;
		scale_y = fast.has.scale_y ? Std.parseFloat(fast.att.scale_y) : 1;
		pivot_x = fast.has.pivot_x ? Std.parseFloat(fast.att.pivot_x) : 0;
		pivot_y = fast.has.pivot_y ? Std.parseFloat(fast.att.pivot_y) : 1;
		a = fast.has.a ? Std.parseFloat(fast.att.a) : 1;
	}
}
