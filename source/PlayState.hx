package;

import flixel.FlxSprite;
import level.*;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxObject;

class PlayState extends GameState
{
	public static var instance:PlayState = null;
	public function new() {
		super();
		instance = this;
	}

	public var levelName:String = "level1";
	public var player:Player;
	public var flagWin:FlxSprite;
	public var levelHandle:LevelBase;

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

		player = new Player(0, 0);
		player.acceleration.y = 900;
		player.maxVelocity.y = 300;
		add(player);

		flagWin = new FlxSprite(0, 0).loadGraphic(AssetPaths.flag_win__png, true, 32, 32);
		flagWin.animation.add("idle", [0, 1, 2, 3, 4, 5, 4, 3, 2, 1], 12, true);
		flagWin.animation.play("idle");
		add(flagWin);

		switch (levelName)
		{
			case "level1":
				levelHandle = new Level1();
		}

		FlxG.camera.zoom = 1.15;
		FlxG.camera.follow(player, PLATFORMER, 0.05);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		levelHandle.update(elapsed);
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
				FlxG.sound.play(AssetPaths.jump__wav);
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

	function gameOver():Void {
		trace("oh no you just dead from falling");
		player.playAnim("dead");
		FlxG.resetState();
	}
}