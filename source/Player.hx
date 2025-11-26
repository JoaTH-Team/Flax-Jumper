package;

import flixel.FlxSprite;

class Player extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
    
        loadGraphic(AssetPaths.player__png, true, 32, 32);
        animation.add("idle", [0]);
        animation.add("run", [1, 2], 30, false);
        animation.play("idle");

        setGraphicSize(64, 64);
        updateHitbox();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
	}
}