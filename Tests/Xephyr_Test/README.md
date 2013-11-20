Xephyr (Remote) Test
====================
This folder contains a test that is intended to simulate the case of opening a window on a remote display, but locally using Xephyr.

The idea is to launch Xephyr, launch a test program using the display address for the Xephyr display server and just see if that worked without anything crashing or so. Then we'd assume that it would work fine on a remote connection too (But we must indeed remember that it does not guarantee that it actually really works on a remote display, but it is kinda an indicator if we broke something badly).
