package com.haxepunk.spriter;

import com.haxepunk.Graphic;

import openfl.Assets;

class Spriter extends Graphic
{
	public function new (source:String, x:Float = 0, y:Float = 0)
	{
		super();
		this.x = x;
		this.y = y;
		
		_scml = new Scml(this, Xml.parse(Assets.getText(source)));
	}
	
	public var angle : Float = 0;
	public var scaleX : Float = 1;
	public var scaleY : Float = 1;
	public var alpha : Float = 1;
	public var spin : Int = 1;
	
	private var _scml : Scml;
}
