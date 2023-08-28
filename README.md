# Dodger Game

A small game I made in Lua using the LOVE2D framework in 2017.

## States System

The most interesting part of this project is not the game itself, but rather the system I developed to keep track of the game's current state.

Most games today have many 'states' - a main menu state, a game state, maybe a map state, and perhaps many others. Across different states, doing the same action - pressing the same key, moving the joystick in the same direction, etc. - might be supposed to produce a completely different response from the game. 

Initially, I had only the game state, and things got confusing when I decided I wanted to have a main menu and maybe even an options screen. How would I know what to draw to the screen? The `update` function would behave differently depending on the state, how would I know what to do? Switching between states seemed like a nightmare - would there be restrictions on which states you could transition to from your current state?

It became clear that there needed to be a central controller over the game's current state - `if` or `switch` statements would be really annoying to develop and read, and if many states needed to be added, they could get really long. 

What I eventually developed was a rudimentary class system. Each state (at this point, just the 'game' and 'menu' states) would be an instance of the State class. Constructing a State would require instructions as to what to do in several circumstances: what to do on startup, on update, what to draw to the screen, what to do upon certain keypresses, etc. But once a particular state is constructed, all we need to do is place the instructions for each circumstances in the proper places.

You can see how I did this by looking at the main.lua file. Instead of having custom actions there, I simply passed along what main.lua received directly to the State file, where the correct state function would be invoked with the appropriate parameters. 

This 'class' system had many advantages. The main.lua file is extremely simple, and not filled with many `if` statements, as was previously mentioned. The State.lua file is also very simple, acting only as a front for the current state. 

The most difficult file to understand is the states.lua file, and even that isn't too difficult. Each state is labelled with a name, hopefully making it easy to understand what each one is for. Additionally, the actions for each state are clearly labelled, and make understanding the code almost as easy as reading English. Want to know what happens during the game at every update? Look in the 'game' state at the 'update' function. Want to know what happens when you press space on the main menu? Look in the 'menu' state at the 'keypressed' function.

Reading this project is not difficult. However, as all developers know, writing to a well-designed project can quickly (and possibly inadvertently) affect that project's design. In the future, working on this project will require a solid grasp on its intended design in order to keep it as clean as it is now. 