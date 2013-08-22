XenUI [![Ohloh project report for XenUI](https://www.ohloh.net/p/xenui/widgets/project_thin_badge.gif)](https://www.ohloh.net/p/xenui)
=====
Experiments with different UI ideas and whatnot.

The core Idea of this project is to create a UI framework that makes desktop interfaces take a leap in terms UI usability and standards. Some ideas are purely experimental, like the ability to just pop a window over to another device without user code ever noticing any differnce.

I want this to be a cross-platform library, but after looking into that, I see that it is a major challange. So the plan is to make a native Linux/X11 implementation using XCB (for speed and brevity) and later implement the platform-specific details using SFML2 (Which in turn is cross-platform, so that would instantly enable a plathora of platforms). Also I wants to learn XCB programming :)

**Why does I create a new UI toolkit?** I did not find anything that I wanted/was suitable to mend into my visions of how an UI Framework _really should work_. ;-)

⁂

__Status__: Currently quite unusable :) Check back later!
Patches are **always** welcome.

Cool Ideas Worth Exploring
--------------------------
I would like it if I could pull of having some kind of system where you just defines what possible actions/events that are aviable when and how in your code, and not touching any actual on-screen GUI code. I mean that the actual looks and function of the GUI-frontend should be specified in a file that is designed by a person, who need not even know how to program at all. Just know how to make a **beautiful** and **useable** GUI ;-)

This would be something like a MVC (Model–view–controller) style thing. But the “View” could possibly be replaced at runtime, which could be useful if you move the window to a smaller screen or you just want a more compact layout. Or whatever reason you can imagine.

I'm not entirely sure yet how I will go about tackling this, but it will problably prove to be an interesting challange.

Build & Configuration
---------------------
For the most part, I tries to keep the configuration automagically :) Right now it only checks to see if you have **[XCB](http://xcb.freedesktop.org/)** installed or not.

For the project/makefiles, you can generate one automatically using [Premake4](http://industriousone.com/premake). Once you have got premake4 you can just execute $ `./build` and it will configure and build in one go using _GNU make_.


