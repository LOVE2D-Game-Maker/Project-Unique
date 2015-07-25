<div align="center"><img src="https://raw.githubusercontent.com/Radfordhound/Project-Unique/master/images/logowhitebig.png" width="604" height="274"></img></div>

**IMPORTANT!!!** This engine is currently in a very early state, and is being re-constructed from scratch at the time of writing. Don't expect things to be complete/work correctly just yet! I'm working on it! :)

"Project Unique" is the engine behind Love Game Maker; a tool allowing kids to easily create games using the LÖVE framework.

It allows for extremely simple coding of games not possible in most other engines!

For example, let's take the simple process of drawing (or "printing") text to the screen.

##It's simpler than other engines!
In **MonoGame**, *(a popular open-source interpretation of Microsoft's game framework, XNA)* drawing "Hello World!" to the screen requires that you first make a "SpriteFont", a large picture containing each individual character from a font. For example, here's a spritefont of the "Arial" font that's included with Microsoft Windows:

![A spritefont of the "Arial" font included with Windows.](https://github.com/Radfordhound/Project-Unique/blob/master/images/READMEimg1.bmp)

There's two basic ways to go about doing this. The first is to simply make the spritefont manually and load it.

Now, normally, this would be quite a hastle! However, the folks over at Microsoft knew this when creating XNA and constructed a tool to help users easily generate spritefonts from regular Windows fonts called "[tff2bmp](http://xbox.create.msdn.com/en-US/education/catalog/utility/bitmap_font_maker)."

You still have to download this separately, though, as it isn't included with XNA (or MonoGame) for whatever reason. You even have to build it yourself as it's released in non-binary form (though this isn't much of a problem as it can be built in Visual Studio, which you'll probably be using to build your XNA/MonoGame application anyway)!

After creating your SpriteFont, you'll want to compile it so you can easily load it in-game. Doing this is easy in XNA as it comes with a special "Content Project" allowing you to easily load all your assets and compile them. In MonoGame, however, no such thing exists, so you'll need to either create a separate XNA Content Project, load your spritefont, build the project, and copy the built file to your MonoGame project, or compile it manually using a third-party tool of some kind.

The second way of making a spritefont is the automatic way.

To do this, you simply make a specially-formatted XML file with the .spritefont extenstion (which XNA provides a template for, unlike MonoGame, unfortunately) and change some basic values within the file (for example, you'd have to change the font name to "Arial").

Then, you simply compile it as with the first method. This is something which, again, is currently easy in XNA and quite a bit more difficult in MonoGame, as it requires you to use a third-party tool of some kind (or simply just compile it with XNA).

After all this, we finally have our spritefont all compiled and ready to go! Now we can **FINALLY** draw some text to the screen!

The code goes something like this (assuming our compiled spritefont is named "font"):

```C#
using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace example
{
    public class Main : Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;
        SpriteFont fnt;

        public Main(): base()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
        }

        protected override void LoadContent()
        {
            spriteBatch = new SpriteBatch(GraphicsDevice);
            fnt = Content.Load<SpriteFont>("font");
        }

        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.Black);

            spriteBatch.Begin();
            spriteBatch.DrawString(fnt,"Hello World!",new Vector2(0,0),Color.White);
            spriteBatch.End();

            base.Draw(gameTime);
        }
    }
}
```

And there ya' go. All that... just to draw some text! And even then the text may look blurry on different screen resolutions!

**Now, in Project Unique, the same task is accomplished like so:**

```Lua
require "ProjectUnique"

function Draw()
	DrawText("Hello World!")
end
```

Just to let that really sink in, that's 37 lines of code in MonoGame vs. 5 lines of code in Project Unique. Both accomplish the same task. You don't have to make a spritefont if you don't want to! Project Unique comes with one... and it's never blurry! You don't even have to set an X and Y position, as Project Unique draws text in the top-left corner of the screen by default! 

Although you certainly can set the X and Y positions like so: "DrawText('Hello World!',**30,70**)" if you wish. ;)

##It's smart!
Let's say you want to draw text using your own font. In MonoGame, this is done using the same process described above. In Project Unique, you just plop your font in it's plain .ttf format in your game's "Resources/Fonts" directory, and do this (assuming your font's in a file called "Arial.ttf"):

```Lua
require "ProjectUnique"

SetFont("Arial.ttf")

function Draw()
	DrawText("Hello World!")
end
```

This'll automatically load Arial.ttf and set the game's font to it, meaning all you need to do is draw some text! Even better, it stores the loaded font in an array called "Fonts" which it checks every time you call "SetFont." **This means calling "SetFont" on the same font(s) multiple times won't bog your game down as Project Unique is smart enough to only load it once!**

It even auto-matically loads all .ttf fonts you place in your game's "Resources/Fonts" folder (provided there are any), so you won't have to keep changing the game's font when your game starts up just to load them all into Project Unique's font array!

##It's flexible!
While Project Unique was designed to be as simplistic as possible, it was also built with the more advanced programmers in mind!

For example, let's say you frequently use more advanced coding functions such as the Ternary conditional operator ('?') used by various langauges such as C++. Lua (the language used by Project Unique), by defaut, doesn't have such a thing *(you can replicate it like so: "(i < 0 and 'result1' or 'result2'))", which would be the equivilent of "(i < 0) ? 'result1' : 'result2'", however, this isn't the real deal, simply a "hack" to try and re-create it, and as such doesn't always behave as you'd expect)*.

**But Project Unique comes with a built-in Ternary function!** This means instead of doing something similar to this:

```Lua
require "ProjectUnique"

local i = 7

function Draw()
	if i >= 7 then
		str = "greater than or equal to 7."
	else
		str = "less than 7."
	end
	
	DrawText("i is " .. str)
end
```

Or this:

```Lua
require "ProjectUnique"

local i = 7

function Draw()
	if i >= 7 then
		DrawText("i is greater than or equal to 7.")
	else
		DrawText("i is less than 7.")
	end
end
```

You can just do this:

```Lua
require "ProjectUnique"

local i = 7

function Draw()
	DrawText("i is " .. Ternary((i >= 7),"greater than or equal to 7.","less than 7."))
end
```

You can even chain Project Unique's Ternary functions together, just like you'd chain the real Ternary conditional operators! For example:

```Lua
require "ProjectUnique"

local i = 7

function Draw()
	DrawText("i is " .. Ternary((i >= 7),Ternary((i == 7),"equal to 7.","greater than 7."),"less than 7."))
end
```

##It's object-oriented!
Another way Project Unique rocks is in method of handling objects. By default, Lua doesn't support object orientation... which is pretty un-acceptable for a modern-day language! To get around this, **Project Unique uses a library known as [HUMP](http://vrld.github.io/hump) which**, amoungst many other
things, **adds support for classes!**

Because of this, you can code games using objects without pulling your hair out using a structure similar to YoYo Game's "Game Maker!"

First, make a **room**. This is sort of a 'level' for your game and is where all objects can easily be spawned.

```Lua
room1 = Room:clone() --This makes a new room called 'room1' based off of the Room class defined by Project Unique

function room1:Load() --This is what the game does when this room is loaded.
	--Spawn all your objects here--
end

return room1() --This hands your room over to Project Unique, which automatically adds it to it's list of rooms.
```

Place this file in your game's "Resources/Rooms" folder so Project Unique will auto-load it.

Next, place the image (also known as a "**sprite**") you want your object to draw in your game's "Resources/Sprites" folder so Project Unique will auto-load it.

Then, make your **object** itself. Objects can be basically anything, but are most commonly-used in games as, well, objects! For example, in "Super Mario Bros." on the NES, Mario would be an object as well as all the bricks, coins, power-ups, and enemies! Objects are really great for when you need tons of something in your game, as you only have to code it once!

In this example, we'll make a coin and call it "obj_coin." Assuming our sprite's filename is "coin.png", this is done like so:

```Lua
obj_coin = Object:clone() --This makes a new Object called 'obj_coin' based off of the Object class defined by Project Unique

function obj_tst:Create() --This is what the game does when you spawn an instance of this object.
	self.sprite = Sprite("coin.png") --Load "coin.png" (If it's not already loaded.) and set obj_coin's sprite to it. :)
end
```

Lastly, go back to the code for your room, and **in the "Load" function, spawn a couple coins.**

```Lua
room1 = Room:clone() --This makes a new room called 'room1' based off of the Room class defined by Project Unique

function room1:Load() --This is what the game does when this room is loaded.
	self:AddObject(obj_coin,0,0) --Spawns a coin at X:0, Y:0 (The top-left of the screen.)
	self:AddObject(obj_coin,30,22) --Spawns a coin at X:30, Y:22 (Think of grids in math, but where the Y axis is reversed, so positive values are lower on the screen than negative ones.)
end

return room1() --This hands your room over to Project Unique, which automatically adds it to it's list of rooms.
```

Done! :D Now you have a fully-working coin object you can spawn infinite numbers of, as well as a level to spawn them in! And it only took a couple of minutes! :)

##More README content coming soon!
