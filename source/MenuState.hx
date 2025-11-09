package;

import djFlixel.ui.FlxMenu;
import flixel.FlxState;

class MenuState extends FlxState
{
    var menu:FlxMenu;
    
    override function create() {
        super.create();

        menu = new FlxMenu(30, 50, 0);
        // create page
        menu.createPage("main_menu", "Main Menu").add('
			-|Play|link|nothing
			-|Options|link|@options
			-|Exit|link|exit| ?pop=:YES:NO');
        menu.createPage("options", "Options").add('
            -|Full Screen|toggle|set_fullscreen
            -|Back|link|@back
        ');

        // handle event
        menu.onItemEvent = function (event, item) {
            if (event == fire) switch (item.ID) {
                case "set_fullscreen":

                case "exit":
                case "back":
                case _:
            }
        }
    }   
    
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}