package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class AlienCollisionBox extends FlxObject
{
	public var parent:Alien;

	public function new(x:Float, y:Float, width:Float, height:Float, parent:Alien)
	{
		super(x, y, width, height);
		this.parent = parent;
	}
}
