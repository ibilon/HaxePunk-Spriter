import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable(Key.A);
#end
		HXP.screen.smoothing = true;
		HXP.scene = new MainScene();
	}

	public static function main() { new Main(); }

}
