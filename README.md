# Klayton's TweenService Animator:tm: (KTA)

*NOTE: This project is currently W.I.P with little to no documentation. If you're brave enough to touch this code, then pay attention when reading it.*
*You can track current progress in [Roadmap to beta](https://github.com/iamklayton/klay-tween-animator/issues/5)*

This is a custom """"animation"""" system for Roblox that makes use of TweenService with a focus on server-to-client archietchure. Using TweenService allows better flexibility and making animations naturally look smoother, it also allows you to better make procedural animations and/or additive animations if you know what you're doing.

# How does it work?
It's just a ModuleScript that the client can call at any time. It's meant to be used with a style where the server tells all clients to animate a specific rig doing a specific animation (i.e server telling all clients to animate a player when they perform a melee swing).

# Why use this over Roblox's animation system?
No reason. But if I had Subject-106 pointing two SPAS-12s at my head, then I would say the benefits are:
- Better control. You decide how animations look and move.
- Ease of use. Just call PlayKeyframe() whenever the client decides it needs to animate something.
- No need for waiting for animations to load because it's not even animations, it's a sequence of Welds being Tweened in a specific rhythm.
