package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class PlayState extends GameState
{
	var player:Player;

	var floor:FlxSprite;

	override public function create()
	{
		super.create();
		floor = new FlxSprite(0, 300).makeGraphic(FlxG.width, Std.int(FlxG.height * 0.8), FlxColor.GREEN);
		add(floor);

		player = new Player(86, 251);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		handleInput();
	}

	function handleInput():Void
	{
		if (controls.pressed.left || controls.pressed.right) {
			player.x += controls.pressed.left ? -100 : 100;
		}

		if (controls.justPressed.up) {
			
		}	
	}

	function overlapWith(obj1:FlxObject, obj2:FlxObject, doSomething:Dynamic) {
		if (obj1 != null && obj2 != null) {
			if (obj1.overlaps(obj2)) {
				doSomething();
			}
		}
	}
}
