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

class EndState extends FlxState
{
	var score:FlxText;

	public function new(score:Int)
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

		var retryText = new FlxText(0, 0, 0, "Press Z/J to Retry", 16);
		retryText.y = (24 * 270 / 32);
		retryText.color = FlxColor.YELLOW;
		retryText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		retryText.screenCenter(X);

		var gameOverText = new FlxText(0, 0, 0, "Designed by\nBrandyBuizel\n\nCoded by\nKnoseDoge\n\nMusic by\nDanFromBavaria", 8);
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		gameOverText.screenCenter();
		gameOverText.y += 12;
		gameOverText.alignment = "center";

		this.score = new FlxText(0, 0, 0, "FINAL SCORE\n" + score, 16);
		this.score.y = 4 * 270 / 32;
		this.score.color = FlxColor.YELLOW;
		this.score.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		this.score.screenCenter(X);
		this.score.alignment = "center";

		add(retryText);
		add(gameOverText);
		add(this.score);
	}

	override public function update(elapsed:Float)
	{
		if ((FlxG.keys.anyJustPressed([Z, J])))
		{
			clickRestart();
		}
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
