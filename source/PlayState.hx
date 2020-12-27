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
	public var alienCollisionsBoxes:FlxGroup;
	public var hud:HUD;
	public var alientimer:FlxTimer;
	public var santatimer:FlxTimer;
	public var santa:FlxSprite;
	public var random:FlxRandom;

	override public function create()
	{
		super.create();

		bounds = new FlxGroup(2);
		bounds.add(new FlxObject(0, -256, 10, 700));
		bounds.add(new FlxObject(230, -256, 10, 700));
		bounds.forEach((obj:FlxBasic) -> cast(obj, FlxObject).immovable = true);
		add(bounds);
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic("assets/images/night.png", true, 240, 270);
		bg.animation.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], 3, true);
		bg.animation.play('normal');
		add(bg);
		var moon = new FlxSprite(0, 0);
		moon.loadGraphic("assets/images/moon.png", true, 240, 92);
		add(moon);
		var roof = new FlxSprite(0, 270 - 32);
		roof.loadGraphic("assets/images/rooftop.png", false, 240, 32);
		add(roof);
		player = new Player(32, 270 - 57);
		add(player);
		aliens = new FlxSpriteGroup();
		add(aliens);
		alienCollisionsBoxes = new FlxGroup();
		add(alienCollisionsBoxes);
		hud = new HUD();
		add(hud);
		alientimer = new FlxTimer();
		alientimer.start(2, spawnAlien, 0);
		santatimer = new FlxTimer();
		santatimer.start(2, spawnSanta, 1);
		random = new FlxRandom();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, bounds);
		FlxG.overlap(player, alienCollisionsBoxes, (_, box:AlienCollisionBox) -> box.parent.capture());
	}

	public function spawnAlien(timer:FlxTimer)
	{
		var x0 = random.int(-48, 288);
		var x1 = random.int(20, 220 - 48);
		var y = random.int(-96, -48);
		var yoffset = random.int(0, 50);
		var amp = random.int(50, 260);
		var freq = random.float(0.005, 0.10);
		var decayfactor = -random.int(175, 250);
		var decay = random.float(0.0001, 0.000155);

		aliens.add(new Alien(x0, x1, y, yoffset, amp, freq, decayfactor, decay));
	}

	public function spawnSanta(timer:FlxTimer)
	{
		var y = random.int(2, 60);
		var x = random.int(250, 260);
		var speed = random.int(10, 12);
		var time = random.int(30, 70);

		if (santa != null)
		{
			santa.destroy();
		}

		santa = new FlxSprite(x, y);
		santa.loadGraphic("assets/images/santa.png", true, 30, 16);
		santa.animation.add("normal", [0, 1, 2], 3, true);
		santa.animation.play("normal");
		santa.velocity.x = -speed;
		add(santa);

		santatimer.start(time, spawnSanta, 1);
	}
}
