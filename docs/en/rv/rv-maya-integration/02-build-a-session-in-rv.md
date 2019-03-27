---
layout: default
title: Build a Session in RV
permalink: /rv/rv-maya-integration/02-build-a-session-in-rv/
lang: en
---

# Build a Session in RV

The main point to remember about playblasting to RV is that if you leave RV open, each successive playblast will be merged into the RV Session, so you can easily compare the current render with others in the session.

Open the Session Manager (from the *Tools* menu, or by hitting the *x* key) to see a list your playblasts and view them in different ways. Each playblast will have a name provided by Maya, plus a timestamp that RV adds to help you track them. If you want to rename a playblast to something more meaningful, just select it in the Session Manager, and select the *Edit View Info* button from the right-click menu, or hit the button with the *I* on it.

At any point, you can save your Session to a Session File, so that you can easily pick up where you left off. When you return, render one playblast to get RV going, them *File→Merge* to bring in the Session File from the previous session.
