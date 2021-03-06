package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

class Bullet extends FlxSprite
{
	var parent:PlayState;

	public function new(x:Float, y:Float, facing:Int)
	{
		super(x, y);
		parent = cast(FlxG.state);

		this.facing = facing;
		loadGraphic("assets/images/bullet.png", false, 6, 6);
		if (facing == FlxObject.RIGHT)
		{
			flipX = true;
			velocity.set(192, -192);
		}
		else
		{
			velocity.set(-192, -192);
		}
	}
}
