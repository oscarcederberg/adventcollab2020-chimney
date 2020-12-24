package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Alien extends FlxSprite
{
	var GRAVITY:Int = 32;

	var parent:PlayState;
	var x0:Float;
	var x1:Float;
	var amp:Int;
	var freq:Float;
	var decay:Float;
	var dx:Float;
	var step:Int;

	public function new(x:Float, y:Float, amp:Int, freq:Float)
	{
		super(x, y);
		parent = cast(FlxG.state);

		this.x0 = x;
		this.x1 = parent.random.int(20, 270 - 68);
		this.dx = (x1 - x0) / (270 - 61 - 48 - y);
		velocity.x = GRAVITY * dx;
		this.amp = amp;
		this.freq = freq;
		this.decay = 0.006;
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
		velocity.x = dx + amp * Math.exp(-decay * step) * FlxMath.fastSin(freq * step);
		step++;
		super.update(elapsed);

		if (y > 300)
		{
			kill();
		}
	}
}
