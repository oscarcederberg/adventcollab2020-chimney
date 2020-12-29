package chimney;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.util.FlxColor;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

using flixel.util.FlxSpriteUtil;

class HUD extends FlxSpriteGroup
{
	var parent:PlayState;
	var icons:Array<LifeIcon>;
	var lives:Int;

	public var scoreCounter:FlxText;

	public function new()
	{
		super();

		parent = cast(Global.state);
		icons = new Array<LifeIcon>();
		lives = 4;
		for (i in 0...lives)
		{
			var icon = new LifeIcon(i * 28, 0);
			icons.push(icon);
			parent.add(icon);
		}

		scoreCounter = new FlxText(240 - 128 - 4, 4, 128, "0", 16);
		scoreCounter.alignment = "right";
		scoreCounter.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		parent.add(scoreCounter);
	}

	public function hit()
	{
		lives--;
		icons[lives].turn();
		if (lives == 0)
		{
			#if ADVENT
			data.NGio.postPlayerHiscore("chimney", parent.score);
			#end
			Global.switchState(new EndState(parent.score));
		}
	}
}
