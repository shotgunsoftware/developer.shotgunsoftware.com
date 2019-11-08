---
layout: default
title: Getting Started with Toolkit Development
pagename: sgtk-developer-getting-started
lang: en
---

# Getting started with Toolkit development

## Intro

There are number of different ways in which you can develop with Toolkit.

- Writing custom hooks to expand existing app, engine, or framework behaviour
- Writing your own apps, engines or frameworks.
- Or writing your own standalone scripts that make use of the API.

To do any of these things it's important to understand how to work with the Toolkit API.

Shotgun as a whole has three main API's
- Shotgun Python API
- Shotgun REST API
- Shotgun Toolkit API

In this section we cover how to get started with the Shotgun Toolkit API. 
This API is designed to be used along side the Shotgun Python API or REST API, and is not a replacement for them.
Although the Toolkit API does have some wrapper methods, in general whenever you need to access data from your Shotgun site
you will use the Shotgun Python or REST APIs instead.

The Toolkit's API instead focuses on the integrations and management of file paths.
Bellow we have a bunch of Guides designed to get you familiar with the API.

### Generating a path and publishing it

1. [Overview](./developer-guides/generating-path-and-publish/sgtk-developer-generating-path-and-publish.md)
1. [Importing sgtk](./developer-guides/generating-path-and-publish/part-1-importing-sgtk.md)
2. [Getting an Sgtk instance](./developer-guides/generating-path-and-publish/part-2-getting-sgtk-instance.md)
3. [Getting context](./developer-guides/generating-path-and-publish/part-3-getting-context.md)
4. [Creating folders](./developer-guides/generating-path-and-publish/part-4-creating-folders.md)
5. [Using a template to build a path](./developer-guides/generating-path-and-publish/part-5-build-a-path.md)
6. [Finding existing files and getting the latest version number](./developer-guides/generating-path-and-publish/part-6-find-latest-version.md)
7. [Registering a published file](./developer-guides/generating-path-and-publish/part-7-registering-publish.md)
8. [Pulling it all together into a complete script](developer-guides/generating-path-and-publish/part-8-generating-path-and-publish-complete-script.md)

### Bootstrapping and running an app

1. [Overview](./developer-guides/bootstrapping-and-running-an-app/sgtk-developer-bootstrapping.md)
2. [Importing the sgtk API for bootstrapping](developer-guides/bootstrapping-and-running-an-app/part-1-importing-sgtk-for-bootstrapping.md)
2. [Authentication](developer-guides/bootstrapping-and-running-an-app/part-2-authentication.md)
3. [How to bootstrap an engine](developer-guides/bootstrapping-and-running-an-app/part-3-bootstrapping.md)
4. [launching an app](developer-guides/bootstrapping-and-running-an-app/part-4-launching-an-app.md)


