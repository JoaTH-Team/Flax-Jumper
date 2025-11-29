package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxObject;

class PlayState extends GameState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var tilemap:FlxTilemap;

	var canDash:Bool = false;
	var isDashing:Bool = false;
	var dashTimer:Float = 0;
	var dashDuration:Float = 0.2;
	var dashPower:Float = 400;
	var dashDirection:Int = 0;
	var dashVerticalBoost:Float = -150;

	override public function create()
	{
		super.create();

		bgColor = FlxColor.fromString("0x00AAFF");

		player = new Player(0, 0);
		player.acceleration.y = 900;
		player.maxVelocity.y = 300;
		add(player);

		loadTilemap();
		FlxG.camera.zoom = 1.15;
		FlxG.camera.follow(player, PLATFORMER, 0.05);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(tilemap, player);
		handleInput();
		updateDash(elapsed);

		if (player.y > FlxG.height)
		{
			gameOver();
		}
	}

	var speed = 150;
	var justJumped:Bool = false;

	function handleInput():Void
	{
		if (!isDashing)
		{
			if (controls.pressed.left || controls.pressed.right) {
				player.x += controls.pressed.left ? -speed * FlxG.elapsed : speed * FlxG.elapsed;
				player.playAnim("walk");
			} else {
				player.playAnim("idle");
			}

			if (player.isTouching(FLOOR) && controls.justPressed.up) {
				player.velocity.y = -300;
				canDash = true;
				justJumped = true;
				player.playAnim("jump_1");
			}
		}

		if (controls.justPressed.left || controls.justPressed.right) {
			// player.playAnim(controls.justPressed.left ?)
			player.flipX = controls.justPressed.left ? true : false;
		}

		var dashPressed = controls.justPressed.dash;
		var inAir = !player.isTouching(FLOOR);
		
		if (dashPressed && canDash && inAir && !isDashing) {
			handleDash();
		}
		
		if (player.isTouching(FLOOR) && !justJumped) {
			canDash = false;
		}
		
		justJumped = false;
	}

	function handleDash() {
		isDashing = true;
		canDash = false;
		dashTimer = dashDuration;
		
		if (controls.pressed.left) {
			dashDirection = -1;
		} else if (controls.pressed.right) {
			dashDirection = 1;
		} else {
			dashDirection = 1;
		}
		
		player.velocity.x = dashDirection * dashPower;
		player.velocity.y = dashVerticalBoost;
	}

	function updateDash(elapsed:Float) {
		if (isDashing) {
			dashTimer -= elapsed;
			
			player.playAnim("jump_2");
			if (dashTimer <= 0) {
				endDash();
			}
		}
	}

	function endDash() {
		isDashing = false;
		if (!isDashing) {
			player.velocity.x = 0;
			player.playAnim("idle");
		}
	}

	function loadTilemap(name:String = "level1") {
		map = new FlxOgmo3Loader('assets/data/chapter 1/$name.ogmo', 'assets/data/chapter 1/$name.json');
		tilemap = map.loadTilemap('assets/images/tilemap/grassblock.png', "tilemap");
		tilemap.follow();

		tilemap.setTileProperties(1, ANY);
		for (i in 2...5) {
			tilemap.setTileProperties(i, NONE);
		}
		
		tilemap.immovable = true;
		add(tilemap);

		map.loadEntities(loadEntity, "entity");
	}

	function loadEntity(entity:EntityData) {
		switch (entity.name) {
			case "player":
				player.setPosition(entity.x, entity.y);
			case "hole event 1":
		}
	}

	function gameOver():Void {
		trace("oh no you just dead from falling");
		player.playAnim("dead");
		FlxG.resetState();
	}

	function overlapWith(obj1:FlxObject, obj2:FlxObject, doSomething:Dynamic) {
		if (obj1 != null && obj2 != null) {
			if (obj1.overlaps(obj2)) {
				doSomething();
			}
		}
	}
}