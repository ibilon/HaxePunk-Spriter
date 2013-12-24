package com.haxepunk.spriter;

class Utils
{
	static inline public function linear (a:Float, b:Float, t:Float)
	{
		return ((b - a) * t) + a;
	}
	
	static inline public function quadratic (a:Float, b:Float, c:Float, t:Float)
	{
		return linear(linear(a, b, t), linear(b, c, t), t);
	}
	
	static inline public function cubic(a:Float, b:Float, c:Float, d:Float, t:Float)
	{
		return linear(quadratic(a, b, c, t), quadratic(b, c, d, t), t);
	}
	
	static inline public function angleLinear (angleA:Float, angleB:Float, spin:Int, t:Float) : Float
	{
		var res : Float;
		
		if (spin == 0)
		{
			res = angleA;
		}
		else
		{
			if (spin > 0)
			{
				if (angleB - angleA < 0)
				{
					angleB += 360;
				}
			}
			else if (spin < 0)
			{
				if (angleB - angleA > 0)
				{    
					angleB -= 360;
				}
			}

			res = linear(angleA, angleB, t);	
		}
		
		return res;
	}
}
