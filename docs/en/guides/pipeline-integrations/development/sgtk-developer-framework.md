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
- [Pre-made {% include product %} frameworks](#pre-made-shotgun-frameworks)
- [Creating a Framework](#creating-a-framework)
- [Using Frameworks from hooks](#using-frameworks-from-hooks)

## What is a Toolkit framework?

Toolkit [frameworks](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#frameworks) are very similar to Toolkit apps. 
The main difference is that a framework is not something you would run on its own.
Instead, you would import a framework into your app or engine. It allows you to keep reusable logic separate so that it can be used in multiple engines and apps.
An example of a framework would be a library of reusable UI components, that might contain a playlist picker component.
You could then import that framework in your app, and plug in the playlist picker component to your main app UI.  

## Pre-made {% include product %} frameworks

{% include product %} supplies some premade [frameworks](https://support.shotgunsoftware.com/hc/en-us/articles/219039798-Integrations-Apps-and-Engines#frameworks) that you may find useful when creating your own apps.
The [Qt Widgets](https://developer.shotgunsoftware.com/tk-framework-qtwidgets/) and [{% include product %} Utils](https://developer.shotgunsoftware.com/tk-framework-shotgunutils/) frameworks are especially useful in app development.

## Creating a Framework

When it comes to creating your own framework, the setup is pretty much the same as writing an app, and you can get more information on that in the ["Developing your own apps"](sgtk-developer-app.md) guide.
Instead of an `app.py` file, a framework has a `framework.py` at the root of the framework package, that contains a class deriving from the [`Framework`](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#framework) base class.
Also, your framework won't register a command with the engine.

Instead, you can either store methods directly on the framework instance itself, or store modules inside the `python/` folder.
For example, the [shotgunutils framework stores them in the python folder](https://github.com/shotgunsoftware/tk-framework-shotgunutils/tree/v5.6.2/python).
To access them, you would import the framework, and then use the [`import_module()` method](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Framework.import_module), to access the submodules.

The API docs contain examples on how to [import frameworks](https://developer.shotgunsoftware.com/tk-core/platform.html?highlight=hide_tk_title_bar#frameworks).

## Using Frameworks from hooks
It can be useful to create a framework so that you can share some common logic across hooks.
A framework can be used in an app, or other framework hooks, even if the app/framework doesn't explicitly require it in the manifest file, via the
[`Hook.load_framework()`](https://developer.shotgunsoftware.com/tk-core/core.html#sgtk.Hook.load_framework) method. Note frameworks can't be used in core hooks even with this method.
