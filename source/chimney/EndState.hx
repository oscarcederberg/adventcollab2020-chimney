package chimney;

import ui.Controls;
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

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class EndState extends FlxState
{
	var score:Int;
	//var button:FlxButton;

	public function new(score:Int)
	{
		this.score = score;
		super();
	}
	
	override function create()
	{
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

		var retryText = new FlxText();
		retryText.scale.set(2, 2);
		retryText.y = (24 * 270 / 32);
		retryText.text = "Press Z to Retry";
		retryText.color = FlxColor.YELLOW;
		retryText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		screenCenter(retryText, X);

		var gameOverText = new FlxText();
		gameOverText.scale.set(1, 1);
		gameOverText.text = "Game by\nBrandyBuizel\nand\nKnoseDoge\n\nMusic by\nDanFromBavaria";
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		screenCenter(gameOverText);
		gameOverText.y += 12;
		gameOverText.alignment = "center";
		
		var scoreText = new FlxText();
		scoreText.scale.set(2, 2);
		scoreText.y = 4 * 270 / 32;
		scoreText.text = "FINAL SCORE\n" + score;
		scoreText.color = FlxColor.YELLOW;
		scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		screenCenter(scoreText, X);
		scoreText.alignment = "center";
		
		/*
		button = new FlxButton(0, 0, "PLAY AGAIN", clickRestart);
		button.scale.set(2, 2);
		button.y = 24 * 270 / 32;
		// button.screenCenter(X);
		*/

		add(retryText);
		add(gameOverText);
		add(scoreText);
		//add(button);
		
		super.create();
	}
	
	inline function screenCenter(obj:FlxObject, ?axes:FlxAxes)
	{
		switch (axes)
		{
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

	override public function update(elapsed:Float)
	{
		if((Controls.pressed.A))
		{
			clickRestart();
		}
	}

	function clickRestart()
	{
		Global.switchState(new PlayState());
	}
}
