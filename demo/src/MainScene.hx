import com.haxepunk.Scene;

import com.haxepunk.spriter.SpriterEntity;

class MainScene extends Scene
{
	public override function begin()
	{
		var spriter : SpriterEntity = new SpriterEntity("sprites/Test.scml", 100, 300);
		add(spriter);
	}
}
