package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class MenuState extends GameState
{
    var menuItem:Array<String> = ["Start", "Options", "Exit"];
    var menuGroup:FlxTypedGroup<FlxText>;
    var menuSelected:Int = 0;

    override function create() {
        super.create();

        menuGroup = new FlxTypedGroup<FlxText>();
        add(menuGroup);

        for (i in 0...menuItem.length) {
            var text = new FlxText(20, 20 + (i * 22), 0, menuItem[i].toUpperCase(), 24);
            text.ID = i;
            text.alignment = LEFT;
            menuGroup.add(text);
        }

        changeSelection();
    }
    
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.justPressed.ui_up || controls.justPressed.ui_down) {
            changeSelection(controls.justPressed.ui_up ? -1 : 1);
        }

        if (controls.justPressed.accept) {
            switch (menuItem[menuSelected])
            {
                case "Start":
                    FlxG.switchState(PlayState.new);
                case "Options":
                    
                case "Exit":
                    Sys.exit(0);
            }
        }
    }

    function changeSelection(change:Int = 0) {
        menuSelected = FlxMath.wrap(change + menuSelected, 0, menuItem.length - 1);
        menuGroup.forEachExists(function (text) {
            var isSelected:Bool = text.ID == menuSelected;
            text.color = isSelected ? FlxColor.YELLOW : FlxColor.WHITE;
        });
    }
}