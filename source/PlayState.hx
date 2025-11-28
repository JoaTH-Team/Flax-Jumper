package;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxObject;

class PlayState extends GameState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var tilemap:FlxTilemap;

	override public function create()
	{
		super.create();

		player = new Player(0, 0);
		add(player);

		loadTilemap();
		FlxG.camera.follow(player, PLATFORMER, 0.05);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		handleInput();
	}

	var speed = 50;
	function handleInput():Void
	{
		if (controls.pressed.left || controls.pressed.right) {
			player.x += controls.pressed.left ? -speed : speed;
		}

		if (controls.justPressed.up) {
			
		}	
	}

	function loadTilemap(name:String = "level1") {
		map = new FlxOgmo3Loader('assets/data/chapter 1/$name.ogmo', 'assets/data/chapter 1/$name.json');
		tilemap = map.loadTilemap('assets/images/tilemap/grassblock.png', "tilemap");
		tilemap.follow();
		tilemap.setTileProperties(1, NONE);
		tilemap.setTileProperties(2, ANY);
		add(tilemap);

		tilemap.loadEntities(loadEntity, "entity");
	}

	function loadEntity(entity:EntityData) {
		switch (entity.name) {
			case "player":
				player.setPosition(entity.x, entity.y);
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
