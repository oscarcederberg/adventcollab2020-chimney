package chimney;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxDirectionFlags;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class Bullet extends FlxSprite
{
	var parent:PlayState;

	public function new(x:Float, y:Float, facing:FlxDirectionFlags)
	{
		super(x, y);
		parent = cast(Global.state);

		this.facing = facing;
		loadGraphic(Global.asset("assets/images/bullet.png"), false, 6, 6);
		if (facing == RIGHT)
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
