---
layout: default
title: What is Shotgun Private Cloud?
pagename: spc-getting_started-about
lang: en
---

# What is Shotgun Private Cloud

Shotgun Private Cloud combines our Cloud Hosted Platform with client managed AWS resources to provide a solution that satisfies the most stringent security and privacy requirements. Clients retain control of their sensitive content without having to host Shotgun on their infrastructure.

Shotgun Private Cloud bring the following advantages compared to our Standard offering:

* Hosting of assets and attachment in a **client owned S3 Bucket**
* **Web traffic isolation** from the public internet
* **Media traffic isolation** from the public internet
* Access to fully managed Shotgun Cloud Services
* Automatic and continuous version upgrade
* Ephemeral compute + in-memory segration between clients

In a nutshell, this means that with Shotgun Private Cloud, your Shotgun site and data related to it can't be reached by people outside of your studio network.

Shotgun Private Cloud is a solution that requires less upkeep and IT/System Administrator knowledge and skills than hosting Shotgun on-premise. The list of advantages compared to on-premise includes, but is not limited to:

* No Shotgun specific knowledge required
* No Shotgun update required
* Very low level of maintenance required for the AWS components

## What Shotgun Private Cloud is not

Shotgun Private Cloud is not a completely isolated solution. The compute services and the database services are shared amongst clients, and managed by Shotgun. Shotgun Private Cloud doesn't garantee a complete segregation from a hardware standpoint.

# High Level Architecture
![spc-arch](../images/spc-about-arch.png)

Shotgun Cloud offerings can be decoupled at a high level in 3 parts;

**Compute Stack.** Part of the Shotgun Service that handles client requests and serves data to the client.

**Data Stack.** Metadata storage (databases)

**Media Storage.** Where the client attachments, media and assets are stored. Shotgun uses AWS S3 to store client content.

## Ephemeral compute and memory segregation
While Shotgun Private Cloud clients share the same infrastructure, Shotgun Cloud guarantees a complete in-memory isolation, but in transit and at rest, of client data. This makes Shotgun Cloud less prone to data leaking due to architecture flaws or software vulnerabilities exploiting memory, like buffer overflow.