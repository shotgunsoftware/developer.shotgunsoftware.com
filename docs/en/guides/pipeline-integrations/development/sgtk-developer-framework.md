---
layout: default
title: Developing frameworks
pagename: sgtk-developer-framework
lang: en
---

# Developing your own framework

## Introduction
This document outlines some of the technical details relating to Toolkit framework development.

Table of Contents:
- [What is a Toolkit framework?](#what-is-a-toolkit-framework)

## What is a Toolkit framework?

Toolkit [frameworks](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#frameworks) are very similar to Toolkit apps. 
The main difference is that a framework is not something you would run on it's own.
Instead, you would import a framework into your app or engine. It allows you to keep reusable logic separate so that it can be used in multiple engines and apps.
An example of a framework would be a library of reusable UI components, that might contain a playlist picker component.
You could then import that framework in your app, and plugin the playlist picker component to your main app UI.  

## Creating a Framework

When it comes to creating your own framework, it is pretty much the same as writing an app, and you can get more information on that in the ["Developing your own apps"](sgtk-developer-app.md) guide.
The main differences, are that you will have a `framework.py` at the root of your framework package, that contains a class deriving from [`Framework`](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#framework).
Your framework won't register a command with the engine unlike an app.
The API docs contain examples of how to [import it](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#frameworks).

## Pre-made Shotgun frameworks

Shotgun supplies some premade [frameworks](https://support.shotgunsoftware.com/hc/en-us/articles/219039798-Integrations-Apps-and-Engines#frameworks), that you may find useful when creating your own apps.
The [QT Widgets](https://developer.shotgunsoftware.com/tk-framework-qtwidgets/) and [Shotgun Utils](https://developer.shotgunsoftware.com/tk-framework-shotgunutils/) in particular are useful in general app development.

## Using Frameworks from hooks
It can be useful to create a framework so that you can share some common logic across hooks.
Frameworks can be used in app, engine or other framework hooks, even if the app/engine/framework doesn't explicitly require it in the manifest file, via the
[`Hook.load_framework`](https://developer.shotgunsoftware.com/tk-core/core.html#sgtk.Hook.load_framework) method. Note frameworks can't be used in core hooks so this would work there.

#TODO check if frameworks can be used from engine hooks?