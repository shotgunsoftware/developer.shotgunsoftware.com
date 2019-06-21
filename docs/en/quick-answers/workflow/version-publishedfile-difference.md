---
layout: default
title: What's the difference between a Version and a PublishedFile?
pagename: version-publishedfile-difference
lang: en
---

# What's the difference between a Version and a PublishedFile?

A **"Publish"** represents a file (or an image sequence) or data on disk which can be used inside an application. It could be an exr sequence, an abc, a Maya file, etc. Publishes are represented by the `PublishedFile` entity in Shotgun.

A **"Version"** (the `Version` entity in Shotgun) is the visual representation of a publish — and is used for review and taking notes. There is a field on the `Version` entity named Published Files which you can populate with any number of publish records to connect them together. This is how you can keep track of which review `Version` is associated with a group of publishes. We recommend that you populate this relationship when you publish. Versions are represented by the `Version` entity in Shotgun.

The ultimate idea is that when you publish, you may generate a collection of files — sometimes different file formats but effectively the same content (a Maya file, an obj, an alembic, etc.) — and these are all different representations of the same thing. They are then associated with a single review `Version` for previewing the publish data and taking notes.

This idea becomes a little bit redundant when the published data is an image sequence. Effectively the image sequence is both the thing you want to review and the thing that will be sent down the pipe. In this case you may have to "double up" and create both a publish and a `Version`. This allows you to load the published data (e.g. via the Loader app) that represents the `Version`.

