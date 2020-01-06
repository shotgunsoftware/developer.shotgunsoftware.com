---
layout: default
title: Development
pagename: toolkit-development
lang: en
---

# Development

## What is Toolkit?

Toolkit is the platform that underpins our pipeline integrations. 
For example, If you are using the Shotgun Panel app in Maya or launching the Publish app from Shotgun Create, you are using tools built upon the Toolkit platform.

## How can I develop with Toolkit?

There are a number of different ways in which you can develop with Toolkit.

- Writing custom code, in what we call hooks, to expand the existing app, engine, or framework behavior.
- Writing your own apps, engines or frameworks.
- Or writing your own standalone scripts that make use of the API.

To do any of these things it's important to understand how to work with the Toolkit API.

Shotgun as a whole has three main API's
- [Shotgun Python API](https://developer.shotgunsoftware.com/python-api)
- [Shotgun REST API](https://developer.shotgunsoftware.com/rest-api/)
- [Shotgun Toolkit API](https://developer.shotgunsoftware.com/tk-core)

The Toolkit API is designed to be used alongside the Shotgun Python API or REST API, and is not a replacement for them.
Although the Toolkit API does have some wrapper methods, in general whenever you need to access data from your Shotgun site you will use the Shotgun Python or REST APIs instead.

The Toolkit API instead focuses on the integrations and management of file paths.
Some Toolkit apps and frameworks also [have their own APIs](../../reference/pipeline-integrations.md).  

These articles will guide you through how you can develop with Toolkit.