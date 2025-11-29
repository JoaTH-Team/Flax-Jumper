package;

import flixel.input.keyboard.FlxKey;
import flixel.addons.input.FlxControls;

enum GameAction {
    // game control
    left;
    right;
    up;
    dash;

    // menu control
    ui_left;
    ui_down;
    ui_up;
    ui_right;

    // global control
    accept;
    back;
}

class GameControl extends FlxControls<GameAction> {
    function getDefaultMappings():ActionMap<GameAction> {
        return [
            GameAction.left => [getFromString("LEFT")],
            GameAction.right => [getFromString("RIGHT")],
            GameAction.up => [getFromString("UP")],
            GameAction.dash => [getFromString("SPACE")],
            GameAction.ui_left => [getFromString("LEFT")],
            GameAction.ui_down => [getFromString("DOWN")],
            GameAction.ui_up => [getFromString("UP")],
            GameAction.ui_right => [getFromString("RIGHT")],
            GameAction.accept => [getFromString("ENTER")],
            GameAction.back => [getFromString("ESCAPE")]
        ];
    }

    public function getFromString(keyStr:String = "ANY") {
        return FlxKey.fromString(keyStr);
    }
}