package com.haxepunk.spriter;

import com.haxepunk.Entity;

import openfl.Assets;

class SpriterEntity extends Entity
{
	public function new (source:String, x:Float = 0, y:Float = 0)
	{
		super(x, y);
		
		_scml = new Scml(Xml.parse(Assets.getText(source)));
	}
	
	private var _scml : Scml;
}
