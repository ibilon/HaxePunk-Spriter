package com.haxepunk.spriter;

import com.haxepunk.HXP;

class SpatialInfo
{
	public function new (x:Float=0, y:Float=0, angle:Float=0, scaleX:Float=1, scaleY:Float=1, alpha:Float=1, spin:Int=1)
	{
		this.x = x;
		this.y = y;
		this.angle = angle;
		this.scaleX = scaleX;
		this.scaleY = scaleY;
		this.alpha = alpha;
		this.spin = spin;
	}
	
	public var x(default, null) : Float;
	public var y(default, null) : Float;
	public var angle(default, null) : Float;
	public var scaleX(default, null) : Float;
	public var scaleY(default, null) : Float;
	public var alpha(default, null) : Float;
	public var spin : Int;
	
	public function unmapFromParent (parentInfo:SpatialInfo) : SpatialInfo
	{
		var unmapped_x : Float;
		var unmapped_y : Float;
		var unmapped_angle = angle + parentInfo.angle;
		var unmapped_scaleX = scaleX * parentInfo.scaleX;
		var unmapped_scaleY = scaleY * parentInfo.scaleY;
		var unmapped_alpha = alpha * parentInfo.alpha;
		
		if (x != 0 || y != 0)
		{
			var preMultX = x * parentInfo.scaleX;
			var preMultY = y * parentInfo.scaleY;
			var s = Math.sin(parentInfo.angle * HXP.RAD);
			var c = Math.cos(parentInfo.angle * HXP.RAD);
			
			unmapped_x = (preMultX * c) - (preMultY * s);
			unmapped_y = (preMultX * s) + (preMultY * c);
			unmapped_x += parentInfo.x;
			unmapped_y += parentInfo.y;
		}
		else
		{
			unmapped_x = parentInfo.x;
			unmapped_y = parentInfo.y;
		}
		
		return new SpatialInfo(unmapped_x, unmapped_y, unmapped_angle, unmapped_scaleX, unmapped_scaleY, unmapped_alpha, spin);
	}
	
	static inline public function linear (infoA:SpatialInfo, infoB:SpatialInfo, spin:Int, t:Float) : SpatialInfo
	{
		return new SpatialInfo(		
				Utils.linear(infoA.x, infoB.x, t),
				Utils.linear(infoA.y, infoB.y, t),
				Utils.angleLinear(infoA.angle, infoB.angle, spin, t),
				Utils.linear(infoA.scaleX, infoB.scaleX, t),
				Utils.linear(infoA.scaleY, infoB.scaleY, t),
				Utils.linear(infoA.alpha, infoB.alpha, t)
			);
	}
}
