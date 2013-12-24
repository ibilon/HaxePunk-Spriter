import com.haxepunk.Scene;

import com.haxepunk.spriter.Spriter;

class MainScene extends Scene
{
	public override function begin()
	{
		var brawler : Spriter = new Spriter("sprites/brawler/brawler.scml");
		addGraphic(brawler);
		
		var imp : Spriter = new Spriter("sprites/imp/imp.scml");
		addGraphic(imp);
		
		var mage : Spriter = new Spriter("sprites/mage/mage.scml");
		addGraphic(mage);
		
		var orc : Spriter = new Spriter("sprites/orc/orc.scml");
		addGraphic(orc);
	}
}
