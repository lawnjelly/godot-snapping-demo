# godot-snapping-demo

A lot of people have been confused as to how to make pixel snapped 2d retro games in Godot. Hopefully here this simple demo and some guidelines will help. This is how I managed to get pixel perfect snapping to work, there may be other ways.

### Rule 1 - Snap everything to integers (whole numbers)
Godot enables and encourages you to use floating point (fraction) numbers for coordinates, sizes etc. Instead of using floats, use integers in your positions etc, and only apply whole number changes, so the relationship is in integers.

### Rule 2 - Snap by the top left corner, NOT the centre
Godot positions objects using the centre. This is helpful in some ways (e.g. calculating distances between objects), but it is problematic for snapping. Snapping objects should be done by making the top left corner line up on the integer grid.

An easy way of doing this is to make sure your sprites are a multiple of two (e.g. 8x16, 12x24), that way you can use the centre for location and the top left will still hit an integer grid.

### Rule 3 - Snap the background to the integer grid
As with sprites, it is essential that the background is snapped to the integer grid. If your background is 320x240, placing it at 160,120 will ensure that the top left corner is at exactly 0, 0 on the integer grid.

### Rule 4 - Only place, and move objects by integer amounts
This is a little hard to understand. If you move something by non integer amounts, it will lose the exact position on the integer grid. Using the physics engine will give results as float values, which is problematic. You should therefore either quantize these to the grid before applying them to a sprite position, or better still, don't use the physics engine, and do the movement / collision detection yourself. Physics engines are not well suited to pixel games.

# History
I suspect that the reason a lot of newbies have problems with this is that they don't appreciate that old games faced a lot more hard rules than modern games. These rules had a side effect of making the games appear better.

* Positions were based on integers because that was all that was available.
* There was no problem with fractions from physics engines, because there were no physics engines.
* Moves were made by regular amounts. If you wanted something to move slowly, it moved by 1 pixel per frame. Fast, 2 pixels per frame. Very slow, 1 pixel every 2 frames. etc etc.

Old games made for display on a television knew that the refresh rate would be a fixed value. Usually either 50hz (PAL) or 60 hz (NTSC). Therefore moving an object 1 pixel / frame guaranteed a certain speed, and also guaranteed nice smooth jitter free motion on the screen.

## The modern era
A problem occurs in that now we have monitors with a large range of refresh rates. Some even feature variable refresh rates (and this can happen in regular monitors with vsync switched off). This means that if we move a fixed amount of pixels per frame, in `_process`, there is no guarantee to how fast the objects will move.

The alternative which is usually suggested it to move objects in `_physics_process`, which gives a fixed tick rate (defaults to 60hz). This works reasonably and is probably the best option for pixel games.

### Problems with fixed tick rate
The big problem with fixed tick rate is that on some systems, frames will not match up to physics ticks exactly. Sometimes a single tick will be displayed over 2 frames, sometimes over 1. This leads to a visible jitter.

With non-pixel games, there is a solution to this problem - fixed timestep interpolation. It moves objects to fractional positions between each physics tick in order to compensate for this difference between the frame time and the tick time.

The problem is that with pixel games, we can't really use this approach. Or rather, it doesn't work as well, because we can't use fractional positions, so we still get temporal aliasing occurring.
