---
layout: default
title: How to Submit Integrations Fixes
pagename: sgtk-how-to-submit-fixes
lang: en
---

# How to Submit Integrations Fixes

We welcome contributions from the Toolkit community! If you have a potential fix for a bug you've discovered or have implemented a feature you think we should include, we welcome you to follow the guidelines below in order to sent it through the right channels.

## Talk to Us

We encourage you to talk to us about what you want to develop or fix. We may have information that will help steer you in the right direction, or prevent you from doing a lot of unnecessary work. Most importantly, we love talking to our users about what they want to build, how they use Toolkit, and how we can make it more awesome.

## Fork the Repo from Github

Most of the Toolkit engine, app, and framework code is developed in the public on Github. Fork the repo you're modifying from Github to your local environment.

## Make Your Changes

Do your development work locally in a branch and test it out in your own environment to the point you feel confident that it's ready to submit to us. Try and match the style of the existing codebase. Keep your changes focused on your purpose. For example, if you're fixing a bug in 3 lines of code, don't try and modify whitespace issues throughout the file. That will make the Toolkit gremlins angry.

## Comment!

Make sure you add detailed comments about what it is you're doing any why you're doing it. Keep in mind, there will be other people like you who may fork this repo later and will need to understand what your code does and why. Be clear, but don't over-comment either. :)

## Test

Remember that other users will have a wide variety of environments and variables in play that may not match what you have at your studio. Toolkit tries to minimize the impact of these types of things for users but there are always things that could be different in other users' environments. Some examples:

-   Will your code work the same on OS X, Windows, and Linux?
-   Will it work in all supported versions of a Software?
-   Will it work the same whether the user launches from a terminal, SG Desktop, {% include product %}, or perhaps their own custom app?

## Create a Pull Request

Once you're ready, push your changes back to Github and create a pull request. Your pull request should be detailed, explain what your code does, and why the changes are required. When writing this up, think about the user who is coming into this with very little knowledge about this area of code. The public will see your pull request and other users will be happy to understand your well written description!

## Then What?

We will review your pull request when we have time in our sprint. It's very likely we'll comment and ask questions about your code or use case. We may kick back the request and ask you to make changes. Don't be offended! We love contributions but also have deep knowledge about how things will work. We are in this code every day so we don't expect everyone to submit perfect code.

Once we review it, if we accept your pull request, we'll queue it for QA and then it will be merged into our repo and released at some point. The timeline can vary depending on a lot of factors. Please be patient.

We may also politely turn down your pull request. Again, please don't be offended. We appreciate your efforts and contribution. There can be any number of factors that contribute to this. But if you follow the guidelines above, hopefully this won't happen.
