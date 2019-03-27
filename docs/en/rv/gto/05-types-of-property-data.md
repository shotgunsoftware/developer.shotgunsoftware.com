---
layout: default
title: GTO: Types of Property Data
permalink: /rv/gto/05-types-of-property-data/
lang: en
---

# Types of Property Data

The GTO format pre-defines a small number of data types that can be stored as properties. The currently defined types are:

| | | |
|-|-|-|
| `double` | 64 bit IEEE floating point. | [Property Type] |
| `float` | 32 bit IEEE floating point. | [Property Type] |
| `half` | 16 bit IEEE floating point | [Property Type] |
| `int` | 32 bit signed integer.  | [Property Type] |
| `int64` | 64 bit signed integer. | [Property Type] |
| `short` | 16 bit unsigned integer. | [Property Type] |
| `byte` | 8 bit unsigned integer (char). | [Property Type] |
| `bool` | Bit or bit vector. Not currently implemented. | [Property Type] |
| `string` | The string type is stored as a 32 bit integer index into the GTO file’s string table. So storing a lot of strings (especially if there is a lot of redundancy) is reasonably cheap. All strings in the GTO file are stored in this manner. | [Property Type] |

Each of these data types can be made into a vector of that type. For example the float data type can be made into a point `float[3]` or a matrix `float[16]`. To store a scalar element the size of the vector is 1. (e.g. `float[1]`).

In this document, the types are all specified as 2 dimensional arrays ala the C programming language. Here is a complete list of example type forms:

* `float[3]` — the float triple type.
* `float[1] [1]` - a single floating point number.
* `float[3] []` - any number of float triples.
* `float[3] [3]` - three float triples.
* `float[16] []` - any number of a 16 float element.
* `float[4,4] [1]` - a 4x4 float matrix.
* `float[3,3] []` - any number of 3x3 float matrices.
* `float[4,512,128] [7]` - seven four component 512x128 images.
* `float[3,32,32,32] [1]` - a 3 component 32x32x32 volume.
