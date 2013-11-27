the Plan
========
~~ “We're aiming for the Moon!”

Windowing & Rendering
---------------------
I plan to use SFML as the first rendring system, but to handle the creation of windows by means of Xlib/XCB because I want to do stuff that SFML can't handle (as of yet). For example, the support of multiple monitors is a key feature for myself.

Tools
-----
The most important part about this project is not even the GUI library itself, rather it is the design of user-friendly tools that surround it. From what I can see, quite a bunch of the beginners are just perplexed when it comes to GUI programming. And from what I can see, it is just that much things are on a quite lower level than it needs to be.

For exemple, why on earth do you need to make a monstrous file that defines that the program should open up a window and thuck in components here and there. Most of this code is quite similar in many projects anyway, so let's refactor out that into the GUI library where it belongs.

Responsibilities
----------------
The system should not force the programmer into a certain usage model, but there should also exist a standard model that the programmer can use if she wish for convinence. And when s/he is confortable with it, a component should be replaceable to more specifically fit the needs of the application in question.

Modularity
__________
We should also allow for hot-swapping of components, for example one could replace the default rendering engine while the apllication is loaded. This permits rapid interation, the programmer can change the renderer and recompile and see the results of their changes immediatly.

Resoucemanagement
_________________
A built-in soloution for resource loading and management should exist, but there should also be a way to let the programmer have more control of this aspect. For example, the application might use the same resources as the GUI uses in another part of the application, if we force the handling of resources ourselves, this might lead to the case when the same file is loaded and decoded into multiple places. That is just waste of system resources.

