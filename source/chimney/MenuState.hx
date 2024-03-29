package chimney;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import ui.Controls;
#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class MenuState extends FlxState
{
	override function create()
	{
		super.create();

		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(Global.asset("assets/images/night.png"), true, 240, 270);
		bg.animation.add("normal", [for(i in 0...21) i], 3, true);
		bg.animation.play('normal');
		add(bg);
		var moon = new FlxSprite(0, 0);
		moon.loadGraphic(Global.asset("assets/images/moon.png"), true, 240, 92);
		add(moon);
		var roof = new FlxSprite(0, 270 - 32);
		roof.loadGraphic(Global.asset("assets/images/rooftop.png"), false, 240, 32);
		add(roof);

		var titleText = new FlxText(0, 0, 0, "HOLIDAY HOMINID DROP", 16);
		titleText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		titleText.y = (6 * 270 / 32);
		screenCenter(titleText, X);

		var startText = new FlxText(0, 0, 0, "Press J/Z to Start", 16);
		startText.y = (24 * 270 / 32);
		startText.color = FlxColor.YELLOW;
		startText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		screenCenter(startText, X);

		var tutorialText = new FlxText(0, 0, 0,
			"Catch as many alien hominids as possible\nby moving left and right (ARROWS or WASD).\nWatch out for agents, they'll shoot\nem down, so knock 'em out!",
			8);
		tutorialText.scale.set(1, 1);
		tutorialText.y = (16 * 270 / 32);
		tutorialText.color = FlxColor.YELLOW;
		tutorialText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		screenCenter(tutorialText, X);
		tutorialText.alignment = "center";

		add(titleText);
		add(startText);
		add(tutorialText);
	}

	override public function update(elapsed:Float)
	{
		if (Controls.justPressed.A)
		{
			clickStart();
		}
	}

	function clickStart()
	{
		Global.switchState(new PlayState());
	}
	
	inline function screenCenter(obj:FlxObject, ?axes:FlxAxes)
	{
		switch (axes)
		{
			case NONE:
			case null | XY:
				screenCenterX(obj);
				screenCenterY(obj);
			case X:
				screenCenterX(obj);
			case Y:
				screenCenterY(obj);
		}
	}
	
	inline function screenCenterX(obj:FlxObject)
	{
		obj.x = (Global.width - obj.width) / 2;
	}
	
	inline function screenCenterY(obj:FlxObject)
	{
		obj.y = (Global.height - obj.height) / 2;
	}
}
