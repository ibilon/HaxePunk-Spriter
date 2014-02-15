import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import com.haxepunk.spriter.Spriter;

class MainScene extends Scene
{
	private var _brawler:Spriter;
	
	public override function begin()
	{
		_brawler = new Spriter("sprites/brawler/brawler.scml");
		addGraphic(_brawler);
		//~ 
		//~ var imp : Spriter = new Spriter("sprites/imp/imp.scml");
		//~ addGraphic(imp);
		//~ 
		//~ var mage : Spriter = new Spriter("sprites/mage/mage.scml");
		//~ addGraphic(mage);
		//~ 
		//~ var orc : Spriter = new Spriter("sprites/orc/orc.scml");
		//~ addGraphic(orc);
	}
	
	public override function update ()
	{
		//Spriter animation
		if (Input.check(Key.SPACE))
			_brawler.playAnim('run');
		
		//camera
		if (Input.check(Key.UP))
			HXP.camera.y -= 10;
		if (Input.check(Key.DOWN))
			HXP.camera.y += 10;
		if (Input.check(Key.LEFT))
			HXP.camera.x -= 10;
		if (Input.check(Key.RIGHT))
			HXP.camera.x += 10;
	}
}
