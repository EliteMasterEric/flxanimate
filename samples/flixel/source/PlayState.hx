package;

import flixel.FlxCamera;
import flxanimate.FlxAnimate;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;

class PlayState extends FlxState
{
	var char:FlxAnimate;

  var availableChars:Array<String> = ["ninja-girl", "picoShoot", "gfDemon", "tankman", "jojo"];
  var currentChar:String;

  var foregroundCamera:FlxCamera;

	override public function create()
	{
    // initBackground();

    // foregroundCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
    // foregroundCamera.bgColor.alpha = 0;
    // FlxG.cameras.add(foregroundCamera, false);

    currentChar = null;
    initChar();

		super.create();
	}

  function initBackground() {
    // Note the background is stored as a bitmap in memory,
    // and uses up like 100mb. Don't use it when performance testing.
		var bg = FlxGridOverlay.create(10, 10, FlxG.width, FlxG.height);
		bg.scrollFactor.set(0.5, 0.5);
		bg.screenCenter();
		add(bg);
  }

  function initChar() {
    if (char != null) {
      remove(char);
      char = null;
    }

    if (currentChar != null) {
      char = new FlxAnimate(0, 0, 'assets/images/${currentChar}');
      char.antialiasing = true;
      // char.cameras = [foregroundCamera];
      add(char);
    }

    if (currentChar == "tankman") {
      // Do callback stuff.
      char.anim.removeAllCallbacksFrom(char.anim.getNextToFrameLabel("idle"));
      char.anim.addCallbackTo(char.anim.getNextToFrameLabel("idle"), function() {
        // Go back to idle.
        char.anim.goToFrameLabel("idle");
      });
    }
  }

	override public function update(elapsed:Float)
	{
    // 0-5 to change character
    if (FlxG.keys.justPressed.ZERO) {
      // If we press 0, the character should be deleted,
      // and total memory usage should be 
      currentChar = null;
      initChar();
    }
    if (FlxG.keys.justPressed.ONE) {
      currentChar = availableChars[0];
      initChar();
    }
    if (FlxG.keys.justPressed.TWO) {
      currentChar = availableChars[1];
      initChar();
    }
    if (FlxG.keys.justPressed.THREE) {
      currentChar = availableChars[2];
      initChar();
    }
    if (FlxG.keys.justPressed.FOUR) {
      currentChar = availableChars[3];
      initChar();
    }
    if (FlxG.keys.justPressed.FIVE) {
      currentChar = availableChars[4];
      initChar();
    }

    if (char == null)
      return;

    // Space to Play/Pause animation
		if (FlxG.keys.justPressed.SPACE)
		{
			if (!char.isPlaying)
				char.playAnim();
			else
				char.pauseAnim();
		}

    // Lock character to cursor.
		char.x = FlxG.mouse.x;
		char.y = FlxG.mouse.y;

    // E/Q to zoom in and out
		if (FlxG.keys.justPressed.E)
			FlxG.camera.zoom += 0.25;
		if (FlxG.keys.justPressed.Q)
			FlxG.camera.zoom -= 0.25;

    // R to reset zoom
    if (FlxG.keys.justPressed.R)
      FlxG.camera.zoom = 1;

    if (currentChar == "tankman") {
      if (FlxG.keys.justPressed.UP) {
        char.anim.goToFrameLabel("singUP");
        char.anim.addCallbackTo(char.anim.getNextToFrameLabel("singUP"), function() {
          // Go back to idle.
          char.anim.goToFrameLabel("idle");
        });
      }
      if (FlxG.keys.justPressed.DOWN) {
        char.anim.goToFrameLabel("singDOWN");
        char.anim.addCallbackTo(char.anim.getNextToFrameLabel("singDOWN"), function() {
          // Go back to idle.
          char.anim.goToFrameLabel("idle");
        });
      }
      if (FlxG.keys.justPressed.LEFT) {
        char.anim.goToFrameLabel("singLEFT");
        char.anim.addCallbackTo(char.anim.getNextToFrameLabel("singLEFT"), function() {
          // Go back to idle.
          char.anim.goToFrameLabel("idle");
        });
      }
      if (FlxG.keys.justPressed.RIGHT) {
        char.anim.goToFrameLabel("singRIGHT");
        char.anim.addCallbackTo(char.anim.getNextToFrameLabel("singRIGHT"), function() {
          // Go back to idle.
          char.anim.goToFrameLabel("idle");
        });
      }
    }


		super.update(elapsed);
	}
}
