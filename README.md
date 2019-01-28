[![Shotgun Developer Docs](https://img.shields.io/badge/Shotgun-Developer%20docs-blue.svg)](http://developer.shotgunsoftware.com/developer-beta/)
[![Build Status](https://secure.travis-ci.org/shotgunsoftware/developer-beta.svg?branch=master)](http://travis-ci.org/shotgunsoftware/developer-beta)



# [developer.shotgunsoftware.com](http://developer.shotgunsoftware.com/developer-beta)

Welcome to the source repository for [developer.shotgunsoftware.com](http://developer.shotgunsoftware.com/developer-beta). This repository holds the markdown source and configuration used to generate the Shotgun developer site.

## How does it work?

The Shotgun Developer site uses continous integration. What you see in the master branch of this repo is
reflected on the developer website. You can use pull requests in order to make changes to the Repository.

The site uses the [Toolkit Documentation Generation system (tk-doc-generator)](https://github.com/shotgunsoftware/tk-doc-generator) to convert markdown, sphinx and other content to a website, complete with search, table of contents etc.

## Making a change to developer.shotgunsoftware.com

If you want to make a change to the content on the developer site, please work in a branch in github
and submit a pull request back. Once you have created a pull request, the system will automatically
generate a preview of the documentation for every change you make.

**NOTE** Your change will initiate a translation request, so make sure to try to bundle up changes 
in as large chunks as possible.

Once your Pull request has been reviewed and approved, merge it with master. Make sure to 
put in a meaningful title and description, and include the pull request id. For example:

[image]


### Page headers

Every page needs to have a standardized header with the following required fields:

```
---
layout: default
title: My Wonderful Page
permalink: /my-wonderful-page/
---
```

**NOTE** Make sure to add the final slash to the permalink. 

In addition, the following fields can be useful:

- `nav_order: 1` - controls the TOC order
- `has_children: true` - for all items that have children
- `external_url: https://support.shotgunsoftware.com/hc/requests/new` - for TOC entries pointing to an external url.
- `parent: My Wonderful Page` - for child pages.

For more information, see the [Toolkit Documentation Generation system (tk-doc-generator)](https://github.com/shotgunsoftware/tk-doc-generator).

### Formatting

For markdown formatting and special syntax, see the [Toolkit Documentation Generation system (tk-doc-generator)](https://github.com/shotgunsoftware/tk-doc-generator).


## Advanced topics

### Technical Details

The setup uses jekyll to convert markdown into a html theme. For more details, see the [Toolkit Documentation Generation system (tk-doc-generator)](https://github.com/shotgunsoftware/tk-doc-generator).

### The landing page

The landing page is controlled by `yml` files in the `_data` folder. For more details, see the comments 
in the files.

### Configuration

The file `jekyll_config.yml` controls the documentation build and will override the master config found inside
the [Toolkit Documentation Generation system (tk-doc-generator)](https://github.com/shotgunsoftware/tk-doc-generator).



