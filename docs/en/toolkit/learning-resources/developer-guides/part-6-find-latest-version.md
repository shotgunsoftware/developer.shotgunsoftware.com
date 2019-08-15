---
layout: default
title: Finding the latest version number
pagename: part-6-find-latest-version
lang: en
---

# Finding existing files and getting the latest version number

There two methods you could use here. 

1. Since in this particular example you are resolving a publish file, you could use the Shotgun API to query for the
next available version number on `PublishedFile` entities.
2. You can scan the files on disk and work out what versions already exist, and extract the next version number. 
This is helpful if the files your working with aren't tracked in Shotgun (such as work files).

Whilst the 1 option would probably be most suitable here, both approaches have their uses so we'll cover them both.