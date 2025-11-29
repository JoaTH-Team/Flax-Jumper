package level;

import flixel.util.FlxColor;
import flixel.FlxG;

class Level1 extends LevelBase
{
    override function create() {
        super.create();

        FlxG.state.bgColor = FlxColor.fromString("0xB000FFAE");
        loadLevel("level1");
    }
}