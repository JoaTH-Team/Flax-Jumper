package;

import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxState;

class MapState extends GameState
{
    var level:Array<String> = ["level1", "level2", "level3", "level4", "level5", "level6", "level7", "level8", "level9", "level10"];
    var levelDisplay:Array<String> = ["Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Level 7", "Level 8", "Level 9", "Level 10"];
    var levelGroup:FlxTypedGroup<FlxText>;
    var levelSelected:Int = 0;

    override function create() {
        super.create();

        levelGroup = new FlxTypedGroup<FlxText>();
        add(levelGroup);

        for (i in 0...levelDisplay.length)
        {
            var text:FlxText = new FlxText(22, 20 + (i * 22), 0, levelDisplay[i].toString(), 24);
            text.ID = i;
            levelGroup.add(text);
        }

        changeSelection();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        
        if (controls.justPressed.ui_up || controls.justPressed.ui_down) {
            changeSelection(controls.justPressed.ui_up ? -1 : 1);
        }
        
        if (controls.justPressed.accept) {
            selectLevel();
        }
    }

    function changeSelection(change:Int = 0) {
        levelSelected = FlxMath.wrap(change + levelSelected, 0, level.length - 1);
        levelGroup.forEach(function (text:FlxText) {
            var isSelected = levelSelected == text.ID;
            text.color = isSelected ? FlxColor.YELLOW : FlxColor.WHITE;
        });
    }
    
    function selectLevel() {
        if (PlayState.instance != null) {
            PlayState.instance.levelName = level[levelSelected];
        } else {
            var playState = new PlayState();
            playState.levelName = level[levelSelected];
            FlxG.switchState(() -> playState);
        }
    }
}