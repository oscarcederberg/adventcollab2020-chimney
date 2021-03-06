package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MenuState extends FlxState
{
	public function new()
	{
		super();

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

		var titleText = new FlxText(0, 0, 0, "HOLIDAY HOMINID DROP", 16);
		titleText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		titleText.y = (6 * 270 / 32);
		titleText.screenCenter(X);

		var startText = new FlxText(0, 0, 0, "Press J/Z to Start", 16);
		startText.y = (24 * 270 / 32);
		startText.color = FlxColor.YELLOW;
		startText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		startText.screenCenter(X);

		var tutorialText = new FlxText(0, 0, 0,
			"Catch as many alien hominids as possible\nby moving left and right (ARROWS or WASD).\nWatch out for agents, they'll shoot\nem down, so knock 'em out!",
			8);
		tutorialText.scale.set(1, 1);
		tutorialText.y = (16 * 270 / 32);
		tutorialText.color = FlxColor.YELLOW;
		tutorialText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		tutorialText.screenCenter(X);
		tutorialText.alignment = "center";

		add(titleText);
		add(startText);
		add(tutorialText);
	}

	override public function update(elapsed:Float)
	{
		if ((FlxG.keys.anyJustPressed([Z, J])))
		{
			clickStart();
		}
	}

	function clickStart()
	{
		FlxG.switchState(new PlayState());
	}
}
