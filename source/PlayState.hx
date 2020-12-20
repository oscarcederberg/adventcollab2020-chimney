package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	public var player:Player;
	public var bounds:FlxGroup;

	override public function create()
	{
		super.create();

		this.bounds = FlxCollision.createCameraWall(FlxG.camera, true, 1, true);

		var bg = new FlxSprite(0, 0);
		bg.loadGraphic("assets/images/night.png", false, 120, 125);
		add(bg);

		var roof = new FlxSprite(0, 135 - 16);
		roof.loadGraphic("assets/images/rooftop.png", false, 112, 16);
		add(roof);

		var player = new Player(16, 90);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
