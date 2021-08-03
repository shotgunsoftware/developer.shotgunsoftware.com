---
layout: default
title: Developer Overview
pagename: developer-overview
lang: en
---

# Developer Overview

### Python API

{% include product %} software provides a Python-based API for accessing {% include product %} and integrating with other tools. The API follows the CRUD pattern allowing execution of Create, Read, Update, and Delete actions on the {% include product %} server. Each request acts on a single entity type and depending on the specific action, can define filters, columns to return, sorting information, and some additional options.

*   [Code Repository](https://github.com/shotgunsoftware/python-api)
*   [Documentation](http://developer.shotgridsoftware.com/python-api/)
*   [Forums](https://community.shotgridsoftware.com/c/pipeline/6)

### Event Trigger Framework

When you want to access the {% include product %} event stream, the preferred way to do so is to monitor the events table, get any new events, process them and repeat.  
  
A lot of stuff is required for this process to work successfully, stuff that may not have any direct bearing on the business rules that need to be applied.  
  
The role of the framework is to keep any tedious monitoring tasks out of the hands of the business logic implementor.  
  
The framework is a daemon process that runs on a server and monitors the {% include product %} event stream. When events are found, the daemon hands the events out to a series of registered plugins. Each plugin can process the event as it wishes.

*   [Code Repository](https://github.com/shotgunsoftware/shotgunevents)
*   [Documentation](https://github.com/shotgunsoftware/shotgunevents/wiki)

### Action Menu Item Framework

API developers can customize context menu items on a per-entity basis. For example, from a Versions page, you could select multiple versions, right-click, then.... Build a PDF Report (for example). We call these ActionMenuItems (AMI's).

*   [Documentation]()
*   [Example Code Repository](http://developer.shotgridsoftware.com/python-api/cookbook/examples/ami_handler.html)
