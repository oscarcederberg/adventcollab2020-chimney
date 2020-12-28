package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

enum AlienState
{
	Floating;
	Falling;
	Captured;
}

class Alien extends FlxSprite
{
	static final GRAVITY:Int = 80;
	static final SCORE:Int = 500;

	var parent:PlayState;
	var currentState:AlienState;
	var marker:Marker;

	var x0:Float;
	var x1:Float;
	var yoffset:Float;
	var dx:Float;
	var amp:Int;
	var freq:Float;
	var decayfactor:Int;
	var decay:Float;

	var col_chimney:AlienCollisionBox;
	var col_chimney_x_offset:Int = 3;
	var col_chimney_y_offset:Int = 33;

	public function new(x0:Float, x1:Float, y:Float, yoffset:Float, amp:Int, freq:Float, decayfactor:Int, decay:Float)
	{
		super(x0, y);
		parent = cast(FlxG.state);
		currentState = AlienState.Floating;
		marker = new Marker(0, 0, this);
		parent.add(this.marker);

		this.x0 = x0;
		this.x1 = x1;
		this.dx = (x1 - x0) / (270 - 57);
		this.yoffset = yoffset;
		this.amp = amp;
		this.freq = freq;
		this.decayfactor = decayfactor;
		this.decay = decay;

		col_chimney = new AlienCollisionBox(x + col_chimney_x_offset, y + col_chimney_y_offset, 22, 11, this);
		col_chimney.immovable = true;
		parent.alienCollisionsBoxes.add(col_chimney);

		loadGraphic("assets/images/alien.png", true, 48, 48);
		animation.add("floating", [0, 1, 2], 6, true);
		animation.add("falling", [3], 1, true);
		animation.add("captured", [4, 5, 6], 6, false);

		animation.play("floating");
	}

	override public function update(elapsed:Float):Void
	{
		if (currentState == AlienState.Floating)
		{
			velocity.y = Math.max(30, GRAVITY - GRAVITY * Math.exp(-0.04 * y));
			x = x0 + dx * y + amp * Math.exp(decayfactor * decay * (y + yoffset)) * FlxMath.fastSin(freq * (y + yoffset));

			col_chimney.x = x + col_chimney_x_offset;
			col_chimney.y = y + col_chimney_y_offset;
		}
		else if (currentState == AlienState.Captured)
		{
			x = parent.player.x;
			y = parent.player.y - 29;
		}

		super.update(elapsed);

		if (y > 290)
		{
			lose();
		}
	}

	public function capture()
	{
		col_chimney.kill();
		currentState = AlienState.Captured;
		animation.play("captured");
		new FlxTimer().start(0.5, score, 1);
	}

	public function score(timer:FlxTimer)
	{
		parent.updateScore(SCORE);
		marker.kill();
		kill();
	}

	public function lose()
	{
		parent.hud.hit();
		marker.kill();
		kill();
	}
}
