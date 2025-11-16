package;

import flixel.FlxG;
import flixel.FlxState;

class GameState extends FlxState
{
    var controls:GameControl;
    var prompt:AdvancePrompt;
    public function new() {
        super();
        controls = new GameControl("Main");
        FlxG.inputs.addInput(controls);

        prompt = new AdvancePrompt();
        add(prompt);
    }    
}