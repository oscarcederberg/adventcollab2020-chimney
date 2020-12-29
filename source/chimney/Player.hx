package chimney;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import ui.Controls;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class Player extends FlxSprite
{
	static final SPEED:Int = 16 * 32;
	static final DRAG:Int = 16 * 64;
	static final MAXSPEED:Int = 16 * 12;

	var parent:PlayState;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		parent = cast(Global.state);

		loadGraphic("assets/images/chimney.png", false, 32, 32);
	}

	override public function update(elapsed:Float):Void
	{
		drag.x = DRAG;
		maxVelocity.x = MAXSPEED;
		handleInput();

		super.update(elapsed);
	}

	public function handleInput()
	{
		var _left:Bool = Controls.pressed.LEFT;
		var _right:Bool = Controls.pressed.RIGHT;

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
