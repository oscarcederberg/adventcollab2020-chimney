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
	var button:FlxButton;

	public function new(score:Int)
	{
		super();

		var gameOverText = new FlxText();
		gameOverText.scale.set(2, 2);
		gameOverText.y = 8 * 270 / 32;
		gameOverText.text = "Press Z to Retry\nGame by BrandyBuizel and KnoseDoge";
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		gameOverText.screenCenter(X);

		this.score = new FlxText();
		this.score.scale.set(2, 2);
		this.score.y = 12 * 270 / 32;
		this.score.text = "FINAL SCORE: " + score;
		this.score.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		this.score.screenCenter(X);

		/*
		button = new FlxButton(0, 0, "PLAY AGAIN", clickRestart);
		button.scale.set(2, 2);
		button.y = 24 * 270 / 32;
		button.screenCenter(X);
		*/

		add(gameOverText);
		add(this.score);
		//add(button);
	}

	override public function update(elapsed:Float)
	{
		if((FlxG.keys.pressed.Z))
		{
			clickRestart();
		}
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
