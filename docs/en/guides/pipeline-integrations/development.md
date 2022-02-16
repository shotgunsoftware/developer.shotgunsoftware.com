---
layout: default
title: Development
pagename: toolkit-development
lang: en
---

# Development

## What is Toolkit?

Toolkit is the platform that underpins our pipeline integrations. 
For example, If you are using the {% include product %} Panel app in Maya or launching the Publish app from {% include product %} Create, you are using tools built upon the Toolkit platform.

## How can I develop with Toolkit?

There are a number of different ways in which you can develop with Toolkit.

- Writing custom code, in what we call hooks, to expand the existing app, engine, or framework behavior.
- Writing your own apps, engines or frameworks.
- Or writing your own standalone scripts that make use of the API.

To do any of these things it's important to understand how to work with the Toolkit API.

{% include product %} as a whole has three main API's
- [{% include product %} Python API](https://developer.shotgridsoftware.com/python-api)
- [{% include product %} REST API](https://developer.shotgridsoftware.com/rest-api/)
- [{% include product %} Toolkit API](https://developer.shotgridsoftware.com/tk-core)

The Toolkit API is a Python API, designed to be used alongside the {% include product %} Python API or REST API, and is not a replacement for them.
Although the Toolkit API does have some wrapper methods, in general whenever you need to access data from your {% include product %} site you will use the {% include product %} Python or REST APIs instead.

The Toolkit API instead focuses on the integrations and management of file paths.
Some Toolkit apps and frameworks also [have their own APIs](../../reference/pipeline-integrations.md).  

These articles will guide you through how you can develop with Toolkit.