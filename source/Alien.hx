package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Alien extends FlxSprite
{
	var GRAVITY:Int = 80;

	var parent:PlayState;
	var marker:Marker;

	var x0:Float;
	var x1:Float;
	var yoffset:Float;
	var dx:Float;
	var amp:Int;
	var freq:Float;
	var decayfactor:Int;
	var decay:Float;

	public function new(x0:Float, x1:Float, y:Float, yoffset:Float, amp:Int, freq:Float, decayfactor:Int, decay:Float)
	{
		super(x0, y);
		this.parent = cast(FlxG.state);
		this.marker = new Marker(0, 0, this);
		parent.add(this.marker);

		this.x0 = x0;
		this.x1 = x1;
		this.dx = (x1 - x0) / (270 - 57);
		this.yoffset = yoffset;
		this.amp = amp;
		this.freq = freq;
		this.decayfactor = decayfactor;
		this.decay = decay;

		loadGraphic("assets/images/alien.png", true, 48, 48);
		animation.add("float", [0, 1, 2], 3, true);
		animation.add("fall", [3], 1, true);
		animation.add("win", [4, 5], 4, true);

		animation.play("float");
	}

	override public function update(elapsed:Float):Void
	{
		velocity.y = Math.max(30, GRAVITY - GRAVITY * Math.exp(-0.04 * y));

		x = x0 + dx * y + amp * Math.exp(decayfactor * decay * (y + yoffset)) * FlxMath.fastSin(freq * (y + yoffset));

		super.update(elapsed);

		if (y > 300)
		{
			marker.kill();
			kill();
		}
	}
}
