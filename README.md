# Godot_Tween_Testing
Tween All completed does not get called at some point after stopping a tween and starting it again.

In this project, I use a Tween to interpolate the alpha value of a sprite to make it disappear and reappear.
If you hit the 'F1' key, it will reset the animation. This is mimicking behavior in my current project of "resetting" a level.
I was having some unexpected behavior in my game after I would reset a level multiple times.  It would work initially, but when I reset it,
tweened nodes would behave unexpectedly.  I eventually determined that the the on_tween_all_completed() callback was not being called when the
tween ended.  

I uncommented the logic in the on_tween_all_completed() callback except for a print statement.
I moved the logic into the on_tween_completed() callback and it works as expected.
After hitting 'F1' a certain number of times, you will observe the the on_tween_all_completed() callback stops being called.
