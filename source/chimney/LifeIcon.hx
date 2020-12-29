package chimney;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class LifeIcon extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic("assets/images/life.png", true, 32, 32);
		animation.add("on", [0], 1, true);
		animation.add("off", [1], 1, true);
		animation.play("on");
	}

	public function turn()
	{
		animation.play("off");
	}
}
