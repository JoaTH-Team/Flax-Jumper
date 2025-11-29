package;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;

class Coin extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y, AssetPaths.coin__png);
    }    

    override function kill()
    {
        alive = false;
        FlxG.sound.play(AssetPaths.coin__wav);
        FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill});
    }

    function finishKill(_)
    {
        exists = false;
    }
}