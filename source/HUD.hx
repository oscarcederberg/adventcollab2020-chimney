package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxBitmapText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxSpriteGroup
{
	var parent:PlayState;
	var icons:Array<LifeIcon>;
	var lives:Int;

	public function new()
	{
		super();

		parent = cast(FlxG.state);
		icons = new Array<LifeIcon>();
		lives = 4;
		for (i in 0...lives)
		{
			var icon = new LifeIcon(i * 28, 0);
			icons.push(icon);
			parent.add(icon);
		}
	}

	public function hit()
	{
		lives--;
		icons[lives].turn();
		if (lives == 0)
		{
			FlxG.resetState();
		}
	}
}
