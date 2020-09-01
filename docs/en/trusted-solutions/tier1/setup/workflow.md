---
layout: default
title: Setup Workflow
pagename: tier1-setup-workflow
lang: en
---

<script async src="https://unpkg.com/mermaid@8.4.6/dist/mermaid.min.js"></script>

# Setup Workflow

<div class="mermaid" align="center">
graph TB
   a[/Plan Your Setup\]
   b[Migration Test site]
   c[Media Isolation]
   e[Media Traffic Isolation]
   f[Web Traffic Isolation]
   g["Fine Tuning<br>[Optional]"]
   h[\Done/]
   a-->b
   b-->c
   c-->e
   e-->f
   f-.->h
   f-->g
   g-->h
</div>