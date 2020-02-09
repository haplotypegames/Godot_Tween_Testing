# Godot_Tween_Testing
Tween All completed does not get called at some point after stopping a tween and starting it again.

In this project, I use a Tween to interpolate the alpha value of a sprite to make it disappear and reappear.
If you hit the 'F1' key, it will reset the animation. This is mimicking behavior in my current project of "resetting" a level.
I was having some unexpected behavior in my game after I would reset a level multiple times.  It would work initially, but when I reset it,
tweened nodes would behave unexpectedly.  I eventually determined that the the on_tween_all_completed() callback was not being called when the
tween ended.  

To reproduce: Play the project.  Hit the 'F1' key and eventually, the sprite will stop animating.
Observe the print statements and you will see that the on_tween_all_completed() callback doesn't get called. If you comment out the
logic in theon_tween_all_completed() callback and uncomment the logic in the on_tween_completed() callback, it will work correctly.
If you leave the print statement in the on_tween_all_completed() callback, you will see it doesn't get called.
