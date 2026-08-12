# Klayton's TweenService Animator:tm:

*NOTE: This project is currently W.I.P with little to no documentation. If you're brave enough to touch this code, then pay attention when reading it.*
*Currently in beta and is meant to be used for R6 rigs*

This is a custom """"animation"""" system for Roblox that makes use of TweenService with a focus on server-to-client archietchure. Using TweenService allows better flexibility and making animations naturally look smoother, it also allows you to better make procedural animations and/or additive animations if you know what you're doing.

# How does it work?
It's just a ModuleScript that the client can call at any time. It animates by looking through the keyframe provided, and compares the parts inside the keyframes to the rig you want animated, so any parts will be animated as long as they have matching names. But instead of moving the actual parts which is a pain in the ass, it just changes their weld C0 to match the keyframe.
It includes basic animation event detection if you want to time effects or hit registration with your animation.

# Why use this over Roblox's animation system?
No reason. But if I had Subject-106 pointing two SPAS-12s at my head, then I would say the benefits are:
- Better control. You decide how animations look and move.
- Ease of use. Animations are poses instead of clips, keyframes are just models so sharing and making animations is easier.
- No need for waiting for animations to load because it's not even animations, it's a sequence of Welds being Tweened in a specific rhythm.
- Good if you want to replicate the style of old CFrame animations without wanting to smash your head into a brick wall staring at...
<img width="972" height="537" alt="image" src="https://github.com/user-attachments/assets/c41bdcd6-6e52-4ac2-addf-32f4fd4c1c01" />
whatever the fuck this is.

