package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Alien extends FlxSprite
{
	var GRAVITY:Int = 16;

	var parent:PlayState;

	var amp:Int;
	var freq:Float;
	var step:Int;

	public function new(x:Float, y:Float, amp:Int, freq:Float)
	{
		super(x, y);
		parent = cast(FlxG.state);

		this.amp = amp;
		this.freq = freq;
		this.step = 0;
		velocity.y = GRAVITY;

		loadGraphic("assets/images/alien.png", true, 48, 48);
		animation.add("falling", [0, 1, 2], 3, true);
		animation.add("shot", [3], 1, true);
		animation.add("win", [4, 5], 4, true);

		animation.play("falling");
	}

	override public function update(elapsed:Float):Void
	{
		velocity.x = amp * FlxMath.fastSin(freq * step);
		step++;
		super.update(elapsed);

		if (y > 300)
		{
			kill();
		}
	}
}
