---
layout: default
title: Interpretation Strings
permalink: /rv/gto/interpretation-strings/
lang: en
---

# Interpretation Strings

Each property can have an additional string stored with it called the “interpretation”. The intent is to allow applications to provide specific information about the property. For example, a property of type `float[4]` can be interpreted as a homogeneous 3D coordinate, a quaternion, or an RGBA value. The interpretation field can be used to distinguish between them.

Why not just make new primitive GTO types for these? The format’s only purpose is storage of data. By decoupling the interpretation of the data from its storage, each application is allowed to make its own policy while maintaining flexibility for simpler applications.

Here’s a simple example of `gtoinfo` output of a file with an image object in it created with `gtoimage`:

```
object "image" protocol "image" v1
     component "image"
       property string[1][1] "originalFile" interpret as "filename"
       property string[1][1] "originalEncoding" interpret as "filetype"
       property string[1][1] "type"
       property int[1][2] "size"
       property float[3][199168] "pixels" interpret as "RGB"
```

Some of the stings will be application specific. Programs that generically edit GTO files should attempt to preserve the interpretation strings.

It is not an error to define the interpretation for a property as the empty string—in other words, unspecified.

The following strings are not currently part of the format specification but are used by the sample implementation. In a future release we may make these “official”. It’s ok to have multiple space separated strings in the interpretation strings (e.g. “4x4 row-major”).

| | | |
|-|-|-|
| `coordinate` | The data can be of any width or type. For width N the data represents a point in N dimensional space.  | [Interpretation String] |
| `normal` | The data can be of any width or type. For width N the data represents a unit vector prependicular to an N dimensional surface or in the case of N == 2, a curve. | [Interpretation String] |
| `4x4` | The width of the property data should be 16. The data is intended to be interpreted as a 4x4 matrix. For example, the **object.globalMatrix** property of the **Coordinate System** protocol would be a “4x4” property. | [Interpretation String] |
| `3x3` | The width of the property data should be 9. The data is intended to be interpreted as a 3x3 matrix. | [Interpretation String] |
| `row-major` | Indicates that matrix data is in row major ordering. | [Interpretation String] |
| `column-major` | Indicates that matrix data is in column major ordering. | [Interpretation String] |
| `quaternion` | The width of the property should be four. The data should be interpreted as a quaternion. Presumably the type of a quaternion property would be `float[4]` or `double[4]` since these are the only types that make sense. The first element of the data is the real part followed by the “i”, “j”, and “k” imaginary components. | [Interpretation String] |
| `complex` | The width of the property should be two. The data is interpreted as a complex number with the first element being the real part and the second element the imaginary part. | [Interpretation String] |
| `indices` | The data type should be an integral type. The property contains indices. | [Interpretation String] |
| `bbox` | The data type should have an even width. The property contains bounding boxes. | [Interpretation String] |
| `homogeneous` | The width of the property should be two or more. If the width is three, then the data is a two dimensional homogeneous coordinate. If the width is four, then the data is a three dimensional homogeneous coordinate. So for data of width `N` the data represents a homogeneous coordinate in `N-1` dimensions. | [Interpretation String] |
| `RGB` | The width of the property should be three. The data represents a color with red, green, and blue components. | [Interpretation String] |
| `BGR` | The width of the property should be three. The data represents a color with blue, green, and red components. (Reversed `RGB`) | [Interpretation String] |
| `RGBA` | The width of the property should be four. The data represents a color (or pixel) with red, green, blue, and alpha components. | [Interpretation String] |
| `ABGR` | The width of the property should be four. The data represents a color (or pixel) with alpha, blue, green, and red components. (Reversed `RGBA`) | [Interpretation String] |
| `bezier` | The property represents a 2D bezier curve for animation. The type should be a floating point type and the width six. Each element is a key frame value. | [Interpretation String] |
| `weighted` | In the case of bezier animation curves, the curve should be evaluated with weighted tangents. | [Interpretation String] |
