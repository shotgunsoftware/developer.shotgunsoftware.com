---
layout: default
title: Development
pagename: toolkit-development
lang: en
---

# Development

## What is Toolkit?

Toolkit is the framework that underpins our pipeline integrations. 
If you are launching Maya and using Shotgun panel app, or running the Publish app via Shotgun Create, you are using
tools built upon the Toolkit framework.

## How can I develop with Toolkit

There are number of different ways in which you can develop with Toolkit.

- Writing custom hooks to expand existing app, engine, or framework behaviour.
- Writing your own apps, engines or frameworks.
- Or writing your own standalone scripts that make use of the API.

To do any of these things it's important to understand how to work with the Toolkit API.

Shotgun as a whole has three main API's
- Shotgun Python API
- Shotgun REST API
- Shotgun Toolkit API

 
The Toolkit API is designed to be used along side the Shotgun Python API or REST API, and is not a replacement for them.
Although the Toolkit API does have some wrapper methods, in general whenever you need to access data from your Shotgun site
you will use the Shotgun Python or REST APIs instead.

The Toolkit API instead focuses on the integrations and management of file paths.
Some Toolkit apps and frameworks also have their own APIs in addition to the core Toolkit API.  

The sub articles will guide you through how you can develop with Toolkit.