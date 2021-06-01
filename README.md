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

