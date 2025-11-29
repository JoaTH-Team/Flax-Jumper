package level;

import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;

class LevelBase extends FlxSpriteGroup 
{
    var game = PlayState.instance;

    // default tilemap
    var tilemap:FlxTilemap;
    var loader:FlxOgmo3Loader;

    public function new() {
        super();
        create();
    }

    public function create() {}

    public function loadLevel(levelname:String) {
        loader = new FlxOgmo3Loader('assets/data/chapter 1/$levelname.ogmo', 'assets/data/chapter 1/$levelname.json');
		tilemap = loader.loadTilemap('assets/images/tilemap/grassblock.png', "tilemap");
		tilemap.follow();

		tilemap.setTileProperties(1, ANY);
		for (i in 2...5) {
			tilemap.setTileProperties(i, NONE);
		}
		
		tilemap.immovable = true;
		FlxG.state.add(tilemap);

        loader.loadEntities(loadEntity, "entity");
    }

    function loadEntity(entity:EntityData) {
        switch (entity.name) {
            case "player":
                game.player.setPosition(entity.x, entity.y);
            case "flag win":
                game.flagWin.setPosition(entity.x, entity.y);
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        FlxG.collide(tilemap, game.player);

        overlapWith(game.player, game.flagWin, function () {
            trace("Hooray you win, strike!");
            FlxG.resetState();
        });
    }

	function overlapWith(obj1:FlxObject, obj2:FlxObject, doSomething:Dynamic) {
		if (obj1 != null && obj2 != null) {
			if (obj1.overlaps(obj2)) {
				doSomething();
			}
		}
	}
}