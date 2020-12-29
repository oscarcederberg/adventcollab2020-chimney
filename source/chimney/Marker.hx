package chimney;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Marker extends FlxSprite
{
	var alien:Alien;

	public function new(x:Float, y:Float, alien:Alien)
	{
		super(x, y);
		this.alien = alien;

		loadGraphic("assets/images/marker.png", true, 48, 48);
		animation.add("right", [0, 1], 4, true);
		animation.add("left", [2, 3], 4, true);
	}

	override public function update(elapsed:Float):Void
	{
		y = alien.y;
		if (alien.x < -48)
		{
			alpha = 1;
			x = 0;
			animation.play("left");
		}
		else if (alien.x > 240)
		{
			alpha = 1;
			x = 240 - 48;
			animation.play("right");
		}
		else
		{
			alpha = 0;
		}
	}
}
