# Klayton's TweenService Animator:tm:

*NOTE: This project is currently W.I.P with little to no documentation. If you're brave enough to touch this code, then pay attention when reading it.*
*You can track current progress in [Roadmap to 1.0](https://github.com/iamklayton/klay-tween-animator/issues/8)*

This is a custom """"animation"""" system for Roblox that makes use of TweenService with a focus on server-to-client archietchure. Using TweenService allows better flexibility and making animations naturally look smoother, it also allows you to better make procedural animations and/or additive animations if you know what you're doing.

# How does it work?
It's just a ModuleScript that the client can call at any time. It animates by looking through the keyframe provided, and compares the parts inside the keyframes to the rig you want animated, so any parts will be animated as long as they have matching names. But instead of moving the actual parts which is a pain in the ass, it just changes their weld C0 to match the keyframe.
It includes basic animation event detection if you want to time effects or hit registration with your animation.

# Why use this over Roblox's animation system?
No reason. But if I had Subject-106 pointing two SPAS-12s at my head, then I would say the benefits are:
- Better control. You decide how animations look and move.
- Ease of use. Animations are raw data instead of clips. So sharing and making animations is easier.
- No need for waiting for animations to load because it's not even animations, it's a sequence of Welds being Tweened in a specific rhythm.

