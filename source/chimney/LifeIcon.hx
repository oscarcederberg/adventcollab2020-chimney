package chimney;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class LifeIcon extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(Global.asset("assets/images/life.png"), true, 32, 32);
		animation.add("on", [0], 1, true);
		animation.add("off", [1], 1, true);
		animation.play("on");
	}

	public function turn()
	{
		animation.play("off");
	}
}
