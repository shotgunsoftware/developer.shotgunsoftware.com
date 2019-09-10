---
layout: default
title: Bootstrapping and running an app
pagename: sgtk-developer-bootstrapping
lang: en
---

# Bootstrapping and running an app

This guide walks you through the process of initializing a Toolkit engine so that you are able to run custom code or launch apps,
also known as bootstrapping.

Bootstrapping is useful in situations where a Toolkit engine has not already been started and you need to use the API.
For example you might have a processing script that runs on a render farm and needs to utilize the Toolkit API to handle paths and context.
Or you may wish to be able to run your Toolkit app from your favourite IDE.

### Requirements

- An understanding of Python programing fundamentals. 
- A project with an advanced configuration. If you haven't setup a configuration before you can follow the ["Getting started with configurations"](need link) guide.

### Steps

1. [Importing the sgtk API for bootstrapping](part-1-importing-sgtk-for-bootstrapping.md)
1. [Authentication](./part-2-authentication.md)
2. [How to bootstrap an engine](./part-3-bootstrapping.md)
3. [launching an app](./part-4-launching-an-app.md)
