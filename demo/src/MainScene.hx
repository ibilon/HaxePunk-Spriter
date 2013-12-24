import com.haxepunk.Scene;

import com.haxepunk.spriter.Spriter;

class MainScene extends Scene
{
	public override function begin()
	{
		var spriter : Spriter = new Spriter("sprites/Test.scml");
		addGraphic(spriter);
	}
}
