package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

enum TypeButton {
    Default;
    Yes_No;
    Default_With_Cancel;
}

/**
 * `AdvancePrompt`, is just a simple but i like to call is `advance` for no reason
 * 
 * To use this prompt, use function `doSimple(text, typeButton);`
 * 
 * All `typeButton` list:
 * 1. Default: Just a `OK` button
 * 2. Yes_No: With `YES` and `NO` button, each one will have a function callback
 * 3. Default_With_Cancel: Same with `Default` type but with `CANCEL` button 
 */
class AdvancePrompt extends FlxSpriteGroup
{
    public var typeButton:TypeButton = Default;
    public var okText:String = "OK";
    public var yesText:String = "YES";
    public var noText:String = "NO";
    public var cancelText:String = "CANCEL";

    public var bg:FlxSprite;
    public var text:FlxText;

    public function new() {
        super();

        text = new FlxText(0, 0, 0, "", 21);
        text.alignment = CENTER;
        add(text);

        bg = new FlxSprite(0, 0);
        bg.makeGraphic(Std.int(text.width + 50), Std.int(text.height + 50), FlxColor.GRAY);
        bg.screenCenter();
        bg.alpha = 0;
        add(bg);

        text.setPosition(bg.x + 25, bg.y + 25);
    }

    public function doSimple(text:String, typeButton:TypeButton) {
        switch (typeButton) {
            case Default:
            case Yes_No:
            case Default_With_Cancel:
        }
    }
}