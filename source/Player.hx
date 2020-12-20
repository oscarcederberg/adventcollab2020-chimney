package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	var SPEED:Int = 16 * 8;
	var DRAG:Int = 16 * 32;
	var MAXSPEED:Int = 16 * 8;

	var parent:PlayState;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		parent = cast(FlxG.state);

		loadGraphic("assets/images/chimney.png", false, 32, 32);
	}

	override public function update(elapsed:Float):Void
	{
		drag.x = DRAG;
		maxVelocity.x = MAXSPEED;
		handleInput();

		super.update(elapsed);

		FlxG.collide(this, parent.bounds);
	}

	public function handleInput()
	{
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (_left == _right)
		{
			_left = _right = false;
		}

		if (_left)
		{
			acceleration.x = -SPEED;
		}
		else if (_right)
		{
			acceleration.x = SPEED;
		}
		else
		{
			acceleration.x = 0;
		}
	}
}
