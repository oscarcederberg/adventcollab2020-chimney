package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

enum AgentState
{
	Jumping;
	Shooting;
	Dying;
}

class Agent extends FlxSprite
{
	static final SCORE:Int = 250;

	var parent:PlayState;
	var x1:Float;
	var y1:Float;
	var state:AgentState;
	var tween:FlxTween;
	var timer:FlxTimer;

	public function new(x0:Float, y0:Float, x1:Float, y1:Float)
	{
		super(x0, y0);
		parent = cast(FlxG.state);
		this.x1 = x1;
		this.y1 = y1;
		state = AgentState.Jumping;

		if (x1 + 41 / 2 < 240 / 2)
		{
			this.facing = FlxObject.RIGHT;
		}
		else
		{
			this.facing = FlxObject.LEFT;
		}

		loadGraphic("assets/images/fbi.png", false, 41, 51);
		if (this.facing == FlxObject.RIGHT)
		{
			flipX = true;
		}

		tween = FlxTween.quadMotion(this, x0, y0, (x0 + x1) / 2, parent.random.int(80, 120), x1, y1, 1, true, {
			type: FlxTweenType.ONESHOT,
			ease: FlxEase.quintOut
		});
		tween.start();

		timer = new FlxTimer();
		timer.start(1, (_) -> land(), 1);
	}

	public function land()
	{
		state = AgentState.Shooting;
		timer.start(0.5, (_) -> shoot(), 1);
	}

	public function shoot()
	{
		if (state == AgentState.Shooting)
		{
			if (facing == FlxObject.RIGHT)
			{
				parent.bullets.add(new Bullet(x + 27, y + 9, facing));
			}
			else
			{
				parent.bullets.add(new Bullet(x + 8, y + 9, facing));
			}
		}
		timer.start(2, (_) -> shoot(), 0);
	}

	public function getHit()
	{
		if (FlxG.pixelPerfectOverlap(this, parent.player))
		{
			if (state == AgentState.Shooting)
			{
				state = AgentState.Dying;

				var random = parent.random;
				if (parent.player.x < x)
				{
					velocity.set(random.float(10 * 64, 30 * 30), -random.float(6 * 64, 15 * 30));
					angularVelocity = random.float(260, 720);
				}
				else
				{
					velocity.set(-random.float(10 * 64, 30 * 30), -random.float(6 * 64, 15 * 30));
					angularVelocity = -random.float(260, 720);
				}
				acceleration.y = 7 * 64;
				parent.updateScore(250);
				timer.start(2, (_) -> kill(), 1);
			}
		}
	}
}
