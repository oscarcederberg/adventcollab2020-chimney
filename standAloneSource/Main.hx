package;

import flixel.FlxG;
import flixel.FlxGame;

import ui.Controls;
import chimney.*;

import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(240, 270, BootState));
	}
}

class BootState extends flixel.FlxState
{
	override function create()
	{
		super.create();
		
		Controls.init();
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		FlxG.switchState(new MenuState());
	}
}