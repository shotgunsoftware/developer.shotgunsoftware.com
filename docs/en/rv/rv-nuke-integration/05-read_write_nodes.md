---
layout: default
title: Read/Write Nodes
permalink: /rv/rv-nuke-integration/05-read_write_nodes/
lang: en
---

# Read/Write Nodes

Once you’ve set the RV path and Session Dir as described above, and have an interesting Nuke script loaded, try starting up RV with the *RV/Start RV* menu item. Assuming you have the *Sync Read Changes* setting active, as soon as RV starts you should see all the Read nodes in the script reflected as media Sources in RV.

If you don’t see the Session Manager, try hitting the *x* to bring it up. In the Session Manager, You’ll see a Folder called “Read Nodes” with a Source for each Read node in the script. Each source is labeled with the name of the corresponding Read node, and a timestamp for when it was last modified.

>**Note:** The Session Manager behavior at RV start-up can be set to “always shown”, “always hidden” or “remember previous state” using the “wrench” menu on the Session Manager.

You can double-click on each Source to play just that one, or on the “Read Nodes” folder to see them all.

Back in Nuke, note that if you edit the Path, Frame Range, or Color Space attributes of a Read node, the changes are reflected in the corresponding Source in RV.

If the *Sync Selection* setting is active, as you select various Read nodes in Nuke, the RV current view switches to the corresponding Source.

Also, if the *Sync Frame* setting is active, frame changes in the Nuke viewer will be reflected in RV.

Note that if you don’t want all Read Nodes to be synced automatically, you can still sync some (or all) of them when you want to with the appropriate items on the *RV* menu.

Pretty much all the above applies to Write nodes as well.
