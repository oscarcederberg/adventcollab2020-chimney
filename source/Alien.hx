package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Alien extends FlxSprite
{
	var GRAVITY:Int = 48;

	var parent:PlayState;
	var x0:Float;
	var x1:Float;
	var dx:Float;
	var amp:Int;
	var freq:Float;
	var decayfactor:Int;
	var decay:Float;

	public function new(x0:Float, x1:Float, y:Float, amp:Int, freq:Float, decayfactor:Int, decay:Float)
	{
		super(x0, y);
		parent = cast(FlxG.state);

		this.x0 = x0;
		this.x1 = x1;
		this.dx = (x1 - x0) / (270 - 57);
		this.amp = amp;
		this.freq = freq;
		this.decayfactor = decayfactor;
		this.decay = decay;

		velocity.y = GRAVITY;

		loadGraphic("assets/images/alien.png", true, 48, 48);
		animation.add("falling", [0, 1, 2], 3, true);
		animation.add("shot", [3], 1, true);
		animation.add("win", [4, 5], 4, true);

		animation.play("falling");
	}

	override public function update(elapsed:Float):Void
	{
		x = x0 + dx * y + amp * Math.exp(decayfactor * decay * y) * FlxMath.fastSin(freq * y);
		super.update(elapsed);

		if (y > 300)
		{
			kill();
		}
	}
}
