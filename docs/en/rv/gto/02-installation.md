---
layout: default
title: GTO: Installation
permalink: /rv/gto/02-installation/
lang: en
---

# Installation

The GTO source code is built using CMake.

## Overview

Historically, GTO format’s primary usage is storage of static geometric data (cached geometry). As such, the types of data you might find in a GTO file are things like polygonal meshes, various types of subdivision surfaces, NURBS or UBS surfaces, coordinate systems, hierarchies of objects, material bindings, and even images.

From a historic point of view, the GTO file format is most closely related to the original inventor file format, the Stanford PLY format and the PDB particle format. Like the Wavefont PDB file format, there are a limited number of simple GTO data types (float, int, string, boolean). Like the inventor file format, a GTO can hold an entire transformation hierarchy including geometric leaf nodes. Like the PLY format, the GTO format can contain an arbitrary amount of data per primitive. Most importantly however, the GTO file format is intended to be very OBJ-like; its relatively easy to read and write and easy to ignore data you don’t want or know about.

GTO files can be either binary or text files. Binary files are the preferred format for large data sets. The GTO text format is intended to be human readable/editable; the syntax is simple and concise. The text format is useful when storing “bag of parameters” files and similar data.

The binary file is either big or little endian on disk, but should be readable on any platform.

The GTO reader can be use libz to read and write compressed files natively. We find that compressed GTO files created by most 3D programs are approximately 60% leaner than uncompressed files.

GTO files conceptually contain objects which are optionally composed of nested namespaces called components. Components are further composed of properties. A property contains an array of one of the predefined data types with up to a four dimensional “shape”. For example, you might have an object which looks something like this:

```
Object “cube”
    Component “points”
      Property float [3][8] “position” Property float[1][8] “mass”
      Property byte[1][8] “type” Property short[1][8] “size”
    Component “indices”
      Property int[1][32] “vertex”
```

Using the terminology above, the object “cube” contains five properties: **position**, **mass**, **type**, **size**, and **vertex**. The **points** component describes the points that make up the cube vertices. Each point has a position and mass stored in properties of the same name. The position property data is composed of eight float &#91;3] data items (or 8 3D points). The **mass** property is composed of a 8 scalar floating point values (one for each point).

The **elements** component contains two properties. **type** indicates the type of the element (for example, triangle, quad, or triangle strip). In this case the elements might all be quads. **size** indicates the number of **vertices** in each of the eight faces (elements) of the cube—(4 for a cube). The vertex property of the **indices** component contains the actual indices: 4 per face for a total of 32.

Of course you could store much more data with the cube object if you wanted to. For example, if you wanted velocity or color per point, this would be another property in the points component.

The meaning of this data is another story altogether. Its all handled by protocol. One application may store things in the GTO file that another application has no method of interpreting even though it can read that data and modify it. In the example above, you need to know to expect that polygonal data is stored in the given properties. The same data could be stored with different property names and a more complex layout. (The “polygon” protocol described later in this document is different and more involved than the above example.)

GTO was (and still is) used by a number of film post production facilities for geometry caching. 3D scenes are evaluated and the final geometry is written into GTO files which are later consumed by a renderer (e.g. RenderMan).

A newer geometry caching format called Alembic was introduced by ILM in 2010 which has a similar purpose and has taken over that role.

## New in Version 4

Version 4 adds two new features: nested components and property types with up to four dimensions.

Version 3 files always had the same structure of
objects.component.property. Nested components allows any number of component names between the object and property:

```
object.component1.component2.component3.property
```

In text GTO files this looks like this:

```
     object
     {
        component1
        {
          component2
          {
            component3
            {
             property ...
             }
          }
        }
     }
```

Where version 3 allowed only a single “width” for properties, version 4 allows up to four dimensions:

```
float[4,10,20,30][3] = [ ... ]
```

The above declares 3 4x10x20x30 float data object.
