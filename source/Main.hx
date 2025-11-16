package;

import flixel.FlxGame;
import openfl.display.*;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
		addChild(new FPS(10, 10, 0xFFFFFF));
	}
}
