[![Build Status](https://secure.travis-ci.org/shotgunsoftware/developer-beta.svg?branch=master)](http://travis-ci.org/shotgunsoftware/developer-beta)
[![Doc Generator](https://img.shields.io/badge/Built%20With-Doc%20Generator-red.svg)](http://travis-ci.org/shotgunsoftware/tk-doc-generator)



# [developer.shotgunsoftware.com](http://developer.shotgunsoftware.com/developer-beta)

Welcome to the source repository for [developer.shotgunsoftware.com](http://developer.shotgunsoftware.com/developer-beta). This repository holds the markdown source and configuration used to generate the Shotgun developer site.

## How does it work?

The Shotgun Developer site uses *continous integration*. What you see in the master branch of this repository is reflected on the developer website. You create github issues and pull requests in order to make changes to the Repository.

The site uses the [Toolkit Documentation Generation system](https://github.com/shotgunsoftware/tk-doc-generator) to convert markdown, sphinx and other content to a website, complete with search, table of contents etc.

# Making a change to the documentation

If you want to make a change to the content on the developer site, please work in a branch in github and submit a pull request. 

## Formatting and style

For documentation on syntax and formatting guidelines, please see 
the **style guide** that comes 
with the documentation generation system.

- [tk-doc-generator style guide](https://developer.shotgunsoftware.com/tk-doc-generator/authoring/)

## Site Preview

Once you have created a pull request, the system will automatically
generate a preview of the full site for every change you make, making
it easy to see what your changes will look like before they are released.

## Documentation Review

Once you have submitted a pull request, it will be reviewed and merged by our team. Once merged, it will become part of the 
official documentation.

## Merging with master

When code is merged into master, make sure to 
put in a meaningful title and description, and include the pull request id. For example:

![PR](pr.png)

