# Godot in-game painting tutorial
This is the full godot project that was created during my YouTube tutorial linked below:

[In-game pixel art in Godot 4: Tutorial](https://www.youtube.com/@algornon)

## How to reference

The majority of the magic happens in the 'canvas.gd' script attached to the 'canvas' scene. The basic idea is update a GridContainer to contain a bunch of 16 x 16 pixel cells that are by default white, then as a user selects a colour and 'draws' over them with their mouse, they will modulate to that colour.

That data is stored as a flat array of colours, then can then be used to create an image texture (in the 'painting.gd' script) by mapping that array into a 2D matrix of pixels and updating the sprite to this created texture.

As a 2D array of colours, this can then be very easily stored in a Resource object to be saved down to disk so you can save your player's drawings using the built-in Resource Saver.

## Get in touch

I hope you find this resource useful! If you have any feedback or questions feel free to get in touch with me on [YouTube](https://www.youtube.com/@algornon) or [Bluesky](https://www.youtube.com/@algornon), where I'm @algornon on both.
