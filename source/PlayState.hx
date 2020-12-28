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
	// bounds that the player collides with, the walls of the game.
	public var bounds:FlxGroup;
	public var agents:FlxTypedSpriteGroup<Agent>;
	public var aliens:FlxTypedSpriteGroup<Alien>;
	// the collision boxes that are checked against the chimney, if they overlap the alien is captured.
	public var alienCollisionsBoxes:FlxGroup;
	public var hud:HUD;
	public var score:Int;
	// spawn timers for aliens and santas
	public var alientimer:FlxTimer;
	public var santatimer:FlxTimer;
	public var agenttimer:FlxTimer;
	public var santas:FlxSpriteGroup;
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
		santas = new FlxSpriteGroup(0, 0);
		add(santas);
		player = new Player(32, 270 - 57);
		add(player);
		aliens = new FlxTypedSpriteGroup<Alien>(0, 0);
		add(aliens);
		agents = new FlxTypedSpriteGroup<Agent>(0, 0);
		add(agents);
		alienCollisionsBoxes = new FlxGroup();
		add(alienCollisionsBoxes);
		hud = new HUD();
		add(hud);

		random = new FlxRandom();

		alientimer = new FlxTimer();
		alientimer.start(2, spawnAlien, 0);
		santatimer = new FlxTimer();
		santatimer.start(2, spawnSanta, 1);
		agenttimer = new FlxTimer();
		agenttimer.start(Math.max(1, random.floatNormal(5, 2)), spawnAgent, 1);
		score = 0;

		FlxG.sound.playMusic("assets/music/bg.mp3", 1, true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, bounds);
		FlxG.overlap(player, alienCollisionsBoxes, (_, box:AlienCollisionBox) -> box.parent.capture());
		if (player.velocity.x != 0)
		{
			FlxG.overlap(player, agents, (_, agent:Agent) -> agent.getHit());
		}
	}

	public function updateScore(score:Int)
	{
		this.score += score;
		hud.scoreCounter.text = Std.string(this.score);
	}

	public function spawnAlien(timer:FlxTimer)
	{
		// x0 is the starting position of the alien in x.
		// x1 is the proposed landing position of the alien in x.
		// alien then calculates the difference/delta in x (dx), and makes sure that the alien moves towards it
		// while floating down.
		var x0 = random.int(-48, 288);
		var x1 = random.int(20, 220 - 48);

		var y = random.int(-96, -48);

		// basically same as phase for the sine wave.
		// also tweaks when the speedup for downard velocity happens.
		var yoffset = random.int(0, 50);

		var amp = random.int(50, 260);
		var freq = random.float(0.005, 0.10);

		// these two variables make sure the alien lands inside the screen by gradually decaying the sine-wave.
		// they are pretty good as is. do not mess with them too much.
		var decayfactor = -random.int(175, 250);
		var decay = random.float(0.0001, 0.000155);

		aliens.add(new Alien(x0, x1, y, yoffset, amp, freq, decayfactor, decay));
	}

	public function spawnAgent(timer:FlxTimer)
	{
		var x0 = random.int(-82, 240 + 82);
		var x1 = random.int(10, 230 - 41);
		var y0 = random.int(270 + 51, 270 + 102);
		var y1 = random.int(191, 196);

		agents.add(new Agent(x0, y0, x1, y1));
		timer.start(Math.max(1, random.floatNormal(5, 2)), spawnAgent, 1);
	}

	public function spawnSanta(timer:FlxTimer)
	{
		var y = random.int(2, 60);
		var x = random.int(250, 260);
		var speed = random.int(10, 12);
		var time = random.int(30, 70);

		santas.forEachAlive((santa:FlxSprite) -> santa.kill());

		var santa = new FlxSprite(x, y);
		santa.loadGraphic("assets/images/santa.png", true, 30, 16);
		santa.animation.add("normal", [0, 1, 2], 3, true);
		santa.animation.play("normal");
		santa.velocity.x = -speed;
		santas.add(santa);

		santatimer.start(time, spawnSanta, 1);
	}
}
