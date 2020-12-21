package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public var player:Player;
	public var bounds:FlxGroup;
	public var aliens:FlxSpriteGroup;
	public var timer:FlxTimer;
	public var random:FlxRandom;

	override public function create()
	{
		super.create();

		this.bounds = new FlxGroup(2);
		this.bounds.add(new FlxObject(0, -256, 10, 700));
		this.bounds.add(new FlxObject(230, -256, 10, 700));
		this.bounds.forEach((obj:FlxBasic) -> cast(obj, FlxObject).immovable = true);
		add(bounds);

		var bg = new FlxSprite(0, 0);
		bg.loadGraphic("assets/images/night.png", false, 240, 270);
		add(bg);

		var roof = new FlxSprite(0, 270 - 32);
		roof.loadGraphic("assets/images/rooftop.png", false, 240, 32);
		add(roof);

		this.player = new Player(32, 209);
		add(player);

		this.aliens = new FlxSpriteGroup();
		add(aliens);

		this.timer = new FlxTimer();
		this.timer.start(3, spawnAlien, 0);

		this.random = new FlxRandom();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, bounds);
		FlxG.collide(aliens, bounds);
	}

	public function spawnAlien(timer:FlxTimer)
	{
		var x = random.int(10, 270 - 58);
		var y = random.int(-128, -48);
		var amp = random.int(64, 256);
		var freq = random.float(1 / 32, 1 / 16);

		aliens.add(new Alien(x, y, amp, freq));
	}
}
