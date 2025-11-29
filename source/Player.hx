package;

import flixel.FlxSprite;

class Player extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
    
        loadGraphic(AssetPaths.player__png, true, 32, 32);
        quickAdd("idle", [0]);
        quickAdd("walk", [1, 2, 3, 4, 5, 6]);
        quickAdd("jump_1", [1, 7]);
        quickAdd("jump_2", [7, 8]);
        quickAdd("dead", [9]);

        playAnim("idle");

        updateHitbox();
    }

    function quickAdd(name:String, amin:Array<Int>, fps:Int = 12) {
        animation.add(name, amin, fps, false);
    }

    public function playAnim(name:String, force:Bool = false) {
        animation.play(name, force);
    }
}