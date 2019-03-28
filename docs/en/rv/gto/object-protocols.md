---
layout: default
title: GTO: Object Protocols
permalink: /rv/gto/object-protocols/
lang: en
---

# Object Protocols

The Object data interpretation is not defined by the GTO format. However, there are currently some protocols in use that are well defined and these are documented here. Caveat emptor: gto files in the wild may contain more data than these protocols define, but they presumably will obey the protocol if they indicate it by name. It’s also possible that some objects may obey more than one protocol yet only indicate that they follow one. Unfortunately, some protocols also specify optional components and properties in case all of this was not confusing enough.

Protocols also have a version number. The version number is an integer; there are no sub-versions. If there are significant changes to a protocol, the version number should be bumped. The version number is not meant as a method of making alternate protocols with the same name. We have had to make three modifications to the protocols since the file format was invented; one to the polygon protocol and one to the transform protocol, and the introduction of a new protocol (connections). The changes are documented in those sections.

In this document, properties are all named “comp.prop”, where “comp” is the name of the component the property belongs to and “prop” is the name of the property. This is done to prevent ambiguity when two different properties in different components but with the same name exist. In the GTO file and when using the reader library only the property name will appear.

There are two kinds of protocols: major and minor. Every object must have a major protocol that’s stored in the ObjectHeader—this is the main indicator of how to interpret the object data. In addition, the object may also have several minor protocols. These indicate optional data and how to interpret it. The next section describes how these are stored in the file.

## Object Protocol

The name of the protocol as it appears in the ObjectHeader is “object” version 1. The protocol does not require any other protocols. Here it is:

|  |  |  |
|-|-|-|
| `object`| A container for properties which don’t fit into other component catagories well. A catch-all data “per-object” component. | [Required Component] |
| `float[16][1] object.globalMatrix` | The global world-space transform for the object. | [Optional Property] |
| `float[6][1] object.boundingBox` | The global world-space bounding box for the object. |  [Optional Property] |
| `string[1][1] object.parent` | Name of this object’s parent in a scene heirarchy. | [Optional Property]  |
| `string[1][1] object.name` | The name of the object. This name should be identical to the name in the ObjectHeader. | [Optional Property] |
| `string[1][] object.protocol` | Additional protocols. This property may contain the main protocol name and any other minor protocols that the object adheres to. If a protocol name appears in this property, the object must adhere to that protocol. Its not an error for a program to output this property with only the major protocol as its value; this is of course redundant since the protocol name is required by the ObjectHeader. It is also not an error for this property to exist but contain nothing. | [Optional Property]  |
| `int[1][] object.protocolVersion` | Additional protocol version numbers. This property may exist if the **object.protocol** property exists. Each entry in this property corresponds to the same entry indexed in the **object.protocol** property. This property must contain the same number of elements that the **object.protocol** property does. | [Optional Property] |

You may be asking why the **object** protocol exists at all. The name of an object is stored in the ObjectHeader in the file and in the C++ library is passed to the reader code. The “name” property is redundant right? Well yes. But some programs will output the name both in the ObjectHeader and in an **object** component as the property “name”.

The main point of this protocol is to define the **object** component. This component is meant to hold data that is “per object” and which doesn’t really fit neatly into other components. The name is one such case. The coordinate system protocol also defines properties in the **object** component and the minor protocols are optionally stored here.

## Coordinate System Protocol

The name of the protocol as it appears in the ObjectHeader is “transform” version 3<sup><a href="#footnote_1">1</a></sup>. The protocol requires the object protocol. Objects which obey the transform protocol will have global matrices and possibly a parent.

| | | |
|-|-|-|
| `object` | From the “object” protocol. | [Required Component] |
| `float[16][1] object.globalMatrix` | A 4x4 matrix of floating point numbers. This matrix describes the world matrix of the coordinate system. |  [Required Property] |
| `string[1][1] object.parent`| The name of an object to which this coordinate system is parented. Presumably this object (if it appears in the gto file) will also obey the **transform** protocol. If this property does not exist or the name is “” (the empty string) then the coordinate system presumably is a root coordinate system.<sup><a href="#footnote_2">2</a></sup> | [Optional Property] |

## Particle Protocol

The name of the protocol as it appears in the ObjectHeader is “particle” version 1. The protocol may include the object and transform protocols.

| | | |
|-|-|-|
| `points` | The points component is transposable. That means that all of its properties are required to have the same number of elements. | [Required Component] |
| `float[3][] points.position` | | [Optional Property] |
| `float[4][] points.position` | The position property is intended to hold the position of the particle in its owncoordinate system or world space if it has no coordinate system. The element is either a 3D or 4D (homogeneous) point | [Optional Property] |
| `float[3][] points.velocity` | The velocity property – if it exists – should hold the velocity vector per-point in the same coordinate system that the “position” property is in. |  [Optional Property] |
| `int[1][] points.id` | The “id” property should it exist will always be defined as an integer per particle (or other integral type if it ever changes). This number should be unique for each particle. Ideally, multiple GTO files with a point that has the same “id” property for a given particle animation should be the same particle. | [Optional Property] |

The **particle** protocol defines the **points** component that many other protocols are derived from. For example, the **NURBS** protocol uses the points defined by the particle protocol as control vertices. There can be any number of properties associated with particles including string per-particle.

The **points** component is marked transposable in the its ComponentHeader. This means that the properties in the component are guaranteed to have the same number of elements. Because of this, the data for the properties in a transposable component may be stored differently than other components. For example, the normal state of affairs is to write data like this:

```
position0 position1 position2 .... positionN
velocity0 velocity1 velocity2 .... velocityN
mass0 mass1 mass2 .... massN
```

So that you must read through all of the particle positions before you can read the first particle’s velocity. But this is not usually the best way to read particle data for rendering. You may want to cull the particles as you read them without storing the data. In order to do this the data needs to be laid out like this:

```
position0 velocity0 mass0
position1 velocity1 mass1
position2 velocity2 mass2
...
```

In this case, each particle is scanned in one chunk allowing for optimizations. Obviously this complicates reading, but in the case of giga-particle renderers, this can be a huge memory savings.

## Strand Protocol

A **strand** object contains a collection of curves. This is somewhat analogous to an object of protocol **particle** as described above.

| | | |
|-|-|-|
| `points` | | [Required Component] |
| `float[3][] points.position` | The CVs which make up each curve. The number of CVs per curve can vary by curve type and size. | [Required Component] |
| `strand` | Information that is relevant to the *all* strands in the object. | [Required Component] |
| `string[1][] strand.type` | String describing curve type. Currently, supported values are linear for degree 1 curves, or cubic for degree 3 curves. |  [Required Property] |
| `float[1][1] strand.width ` | If each end of all curves is the same width, you can just specify that one number instead of the list as with **elements.width** below. |  [Optional Property] |
| `elements` | Information that applies to each separate strand in the object. | [Required Component] |
| `int[1][] elements.size` | This is a list of the sizes of each curve in this object. For example, if there are two curves in this object, with 4 CVs and 3 CVs respectively, then: `elements.size = [ 4 3 ]` | [Required Property]  |
| `float[2][] elements.width` | This is a list of the widths of each end of each curve. The width for each curve will be linearly interpolated over the length. | [Optional Property]  |

## NURBS Protocol

The name of the protocol as it appears in the ObjectHeader is “NURBS” version 1. The protocol requires the **particle** protocol and optionally includes the **object** and **transform** protocols.

| | | |
|-|-|-|
| `points` | see **particle** protocol. The points describe data per NURBS control vertex. | [Required Component] |
| `float[3][] points.position` | | [Required Property] |
| `float[4][] points.position` | The position property holds the control point positions in its own coordinate system or world space if it has no coordinate system. The element is either a 3D or 4D (homogeneous) point. If the type is float[4] the fourth component of the element will be the rational component of the control point position. The control points are laid out in _v-_**major** order (*u* iterates more quickly than *v*). |  [Required Property] |
| `float[1][] points.weight` | If the position property is of type `float[3][]` there may optionally be a “weight” property. This property holds the homogeneous (rational) component of the position. Older GTO writers may export data in this manner. The preferred method is to use a `float[4]` element position. |  [Optional Property] |
| `surface` | Properties related to the definition of a NURBS surface are stored in this component. | [Required Component] |
| `float[1][2] surface.degree` | The degree of the surface in *u* and *v*. | [Required Property]  |
| `float[1][] surface.uKnots` | | [Required Property]  |
| `float[1][] surface.vKnots` | The NURBS surface knot vectors in *u* and *v* are stored in these properties. The knots are not piled. The usual NURBS restrictions on how numbers may be stored in the knot vectors apply. | [Required Property]  |
| `float[1][2] surface.uRange` | | [Required Property]  |
| `float[1][2] surface.vRange` | The range of the knot parameters in *u* and *v*. | [Required Property]  |

The **NURBS** protocol currently does not handle trim curves, points on surface, etc. Ultimately, the intent is to handle the trim curves and other nasties as NURBS curveson-surface which will be stored in additional components. UBS surfaces can be stored as NURBS with non-rational uniform knots.

## Polygon Protocol

The name of the protocol as it appears in the ObjectHeader is “polygon” version 2<sup><a href="#footnote_3">3</a></sup>. The protocol requires the **particle** protocol and optionally includes the **object** and **transform** protocols.

There are a number of alternative configurations of this protocol depending on the value of the **smoothing.method** property. All of these involve the placement of normals in the file.

| | | |
|-|-|-|
| `points` | See **particle** protocol. The points describe data per vertex. | [Required Component] |
| `float[3][] points.position` | The positions for regular polygonal meshes are stored as `float[3]`. |  [Required Property] |
| `float[3][] points.normal` | Normals per vertex. The **smoothing.method** property will have the value of *Smooth* if this property exists. Note that use of the *Smooth* smoothing method does not require that this property exists. If it does not the method is merely and indication of how the normals should be constructed. |  [Optional Property] |
| `normals` | This property is required only if the **normals** component exists and the value of **smoothing.method** is *Partitioned* or *Discontinuous*. |  [Required Property] |
| `elements` | The elements component is transposable. All properties in the elements component must have the same number of elements. Each element corresponds to a polygonal primitive. | [Required Component] |
| `byte[1][] elements.type` | Elements are modeled after the OpenGL primitives of the same name. The vertex order is identical to that defined by GL. The type numbers outside those given here are not defined but reserved for future use. So far, these are the define type numbers: <br/>**0 –** Polygon General N-sided polygon. This can be used for any polygon that has 3 or more vertices.,<br/>**1 –** Triangle A three vertex polygon.,<br/>**2 –** Quad A four vertex polygon.,<br/>**3 –** TStrip Triangle strip.,<br/>**4 –** QStrip Quad strip.,<br/>**5 –** Fan Triangle fan. | [Required Property]  |
| `short[1][] elements.size` | The size of each primitive. Because the type is short, there is a limit of 65k vertices per primitive. | [Required Property]  |
| `short[1][] elements.smoothingGroup` | This property may exist if the value of **smoothing.method** is *Partitioned*. In that case, this property indicates the smoothing group number associated with each element. These can be used to recompute the normals. These numbers are the same as those found in the Wavefront .obj file format’s “s” statements. A value of 0 indicates that an element is not in a smoothing group. | [Optional Property]  |
| `float[3][] elements.normal` | Normals per element. The **smoothing.method** property will have the value of *Faceted* if this property exists. Note: the use of *Faceted* smoothing method does not require that this property exists. If it does not, the smoothing method is merely and indication of how the normals should be created. | [Optional Property]  |
| `indices` | The indices component is transposable. All of its properties are required to have the same number of elements. Each entry in the indices component corresponds to a polygonal vertex.<sup><a href="#footnote_4">4</a></sup> | [Required Component] |
| `int[1][] indices.vertex` | A list of all the polygonal vertex indices in the same order as the **elements.primtives**. The indices refer to the **points.position** property. So if the first polygonal element is a triangle and second is a general four vertex polygon then vertex indices will be something like:<br/> `0 1 2 1 0 3 4 ...`<br/>which would be grouped as:<br/>`(0 1 2) (1 0 3 4) ...`<br/>The first group is the triangle and the second the polygon. | [Required Property]  |
| `int[1][] indices.st` | Similar to the vertex indices but indicates indices into *st* coordinates. These are usually stored in the “mappings” component but may also appear in the **points** component. | [Optional Property]  |
| `int[1][] indices.normal` | Indices into stored normals if there are any. The **smoothing.method** property will have the value of *Partitioned* or *Discontinuous* if this property exists. | [Optional Property]  |
| `mappings` | Contains parametric coordinates. The property names in mappings usually correspond to names found in the **indices** component but not always. For example **mappings.st** would be a `float[2][]` property holding texture coordinates indexed by **indices.st.** | [Optional Component] |
| `smoothing` | The smoothing component exists to hold the smoothing method and any ancillary data for the method. If there is no smoothing component (and hence no **smoothing**) you can assume anything you want. | [Optional Component] |
| `int[1][1] smoothing` | There five defined smoothing methods (0 through 4). They are:<br/>**0 – None** No smoothing method specified. No additional properties associated with normals will appear in the object.<br/>**1 – Smooth** One normal at every vertex. There will be a `float[3][]` **normal** property as part of the **points** component. Each vertex has a unique normal.,<br/>**2 – Faceted** One normal for each face. There will be a `float[3][]` **normal** property in the **elements** component. Each element has a unique normal.,<br/>**3 – Partitioned** Same as the Wavefront .obj smoothing groups. There will be a **normals** component containing a `float[3][]` **normal** property and an `int[1][]` **normal** property in the **indices** component. Each element vertex will have an index into the **normals.normal** property.,<br/>**4 – Discontinuous** Like *Partitioned* but with additional lines and points of discontinuity. The same properties that hold the *Partitioned* information will hold the *Discontinuous* information. There will also be a component called **discontinuities** which will have a `int[1][]` property called **indices** indicating the points and lines of discontinuity. | [Required Property]  |

## Subdivision Surface Protocols

The name of the protocol as it appears in the ObjectHeader is “catmull-clark” or “loop” depending on the intended subdivision scheme. The protocol requires the **polygon** protocol.

The smoothing and any normals properties on the **polygon** protocol should be ignored if they exist.

The protocol indicates how the surface should be treated. Note that the canonical element type for each of the two schemes is not guaranteed to be the only element type stored in the file. For catmull-clark this means that triangles and general polygons will need to be made into quads. Similarily loop surfaces may have quads and other non-triangle primitives that need to be triangulated.

These protocols do not currently define methods for storing edge creasing parameters. Disclaimer: there are restrictions on what kind of topology surfaces are allowed to have for a given renderer (for example). In most cases surfaces need to be manifold. Some applications can deal with special cases better than others.

## Image Protocol

The Image protocol describes image data in the form of an object. This data makes it possible to store texture maps, backgrounds, etc, directly in the GTO file.

When images are stored in a GTO file, use of Gzip compression is highly recommended if the data is unencoded. As of version 2.1, the supplied Reader and Writer classes default to using zlib compression.

If the image data is encoded, its better not to use compression on the GTO file (especially if the file contains only image data).

| | | |
|-|-|-|
| `image` | The image data and other information will be stored in the **image** component. | [Required Component] |
| `int[1][] image.size` | The size (and dimension) of the image. There will be N sizes in this property corresponding to the N dimensions of the image. |  [Required Property] |
| `string[1][1] image.type` | The image type. For interactive purposes, the image channels may correspond to a particular fast hardware layout.<br/>`RGB` Three channels corresponding to red, green, and blue in that order.,<br/>`BGR` Three channels corresponding to blue, green, and red in that order.<br/>`RGBA` Four channels corresponding to red, green, blue, and alpha in that order.<br/>`ABGR` Four channels corresponding to alpha, blue, green, and red in that order.<br/>`L` One channel corresponding to luminance.<br/>`HSV` Three channels corresponding to hue, saturation, and value. (The HSV color space).<br/>`HSL` Three channels corresponding to hue, saturation, and lightness. (The HSL color space).<br/>`YUV` Three channels corresponding to the YUV color space. |  [Required Property] |
| `int[1] image.cs` | The coordinate system of the image. The value of **image.cs** can be any one of the following:<br/>**0 – Lower left origin.**: The first pixel in the image data is the lower left corner of the image data and corresponds to NDC coordinate (0,0).<br/>**1 – Upper left origin.**: The first pixel in the image data is the upper left corner of the image data and corresponds to NDC coordinate (0,0). | [Optional Property] |

Any one of the following properties are required to hold the actual image data:

| | | |
|-|-|-|
| `byte[N][] image.pixels ` | | [Property] |
| `short[N][] image.pixels` | | [Property] |
| `string[1][1] image.type` | | [Property] |
| `half[N][] image.pixels` | The element width determines the number of channels in the image. For example the type `byte[3][]` indicate a 3 channel 8-bit per channel image. The number of elements in this property should be equal to `image.size[0] &#42; image.size[1] &#42; ... image.size[N]` where **image.size** is the property defined above. | [Property] |

### Additional Image Properties Used by GTV Files.

The base GTO library does not deal with encoded image data or tiling of images. GTV is a specialization of the GTO format for storing movie frames. Some of the GTV properties are documented here. (See documentation for the GTV library for more info).

| | | |
|-|-|-|
| `string[1] image.encoding` | If the pixel data is encoded this property will indicate a method to decode it. Typical values are “jpeg”, “jp2000”, “piz”, “rle”, or “zip”. The pixels will be stored in the **image.pixels** as `byte[1][]`. | [OptionalProperty] |

## Material Protocol

The name of the protocol as it appears in the ObjectHeader is “material”. The material protocol groups a parameters and a method (shader) for rendering. The material protocol can optionally include the **object** protocol.

The material definition is renderer and pipeline dependant. Material assignment is implemented using the **connection** protocol. See Section Inter-Object.

The **material** protocol is intended for use with software renderers. Interactive material definitions may be more easily defined on the assigned object.

| | | |
|-|-|-|
| `material ` | Properties unrelated to parameters appear in the **material** component. | [Required Component] |
| `string[1][1] type` | The value of the **material.type** property is renderer dependant. For a RIB renderer, the value of type might be “Surface”, “Displacement”, “Atmosphere” or a similar shader type name. | [Required Property]  |
| `string[1][1] shader` | The name of the shader. For RenderMan-like renderers this might be the name of an “.sl” file. | [Optional Property]  |
| `string[1][1] genre`  | A property to further identify the material. This is most useful for identifying the target renderer for a material. | [Optional Property]  |
| `parameters` | The set of parameters corresponding to the **material.type.** | Optional Component]  |

## Group Protocol

## Inter-Object Connection Protocol

The name of the protocol as it appears in the ObjectHeader is “connection” version 1.

Files which employ the **connection** protocol will typically contain a connection object with the special cookie name “:connections” indicating the purpose of the object as well as preventing namespace pollution. See Section Special Cookies.

Each component in a connection object is a connection type. For example, the “par- ent of” connection type is used to represent transformation hierarchies. In a connection object, there will be a single component called “parent of” which will contain the required properties **parent_of.lhs** and **parent_of.rhs** at a minimum. Some connection types may have additional data in the form of additional properties.

Connection components are transposable. The number of elements in properties comprising a connection component will be consistent. So a single “parent of” component can encode an entire scene transformation hierarchy.

Connection components have the following properties. Note that where **connection_type** occurs in the property name, you would substitute in the actual name of the connection type. (“parent of” for example).

| | |
|-|-|
| `string[1][] connection_type.lhs` | [Required Property] |
| `string[1][] connection_type.rhs` | [Required Property] |

The left-hand-side and right-hand-side of the connection.

* If the connection is directional, then an arrow indicating the direction would have its tail on the left-hand-side and its head pointing at the right-hand-side.
* If the connection type does not require a direction then these properties are still used to describe the two ends of the connection.
* Each entry will be the name of an object. There is no requirement that the ends of the connection exist in the file. For example, one end of the connection could be an image on disk.
* The empty string is a valid value. You could think of the empty string as indicating a grounded connection.
* It is ok for both ends of the connection to have the same value.

The GTO specification includes a couple of basic connection types.

### Transformation hierarchies.

The “parent of” connection type is used to store transformation hierarchies. The connection type requires only the **lhs** and **rhs** properties. Transformation hierarchies are usually tree structures, but can also be DAGs (as is the case with Maya or Inventor).

Using “parent of” as a cyclic generalized network connection is probably an error for most applications. To be safe the topology of a “parent of” network should be a tree.

### Material Assignment

The “material” connection type indicates a material assignment to an object. The left-hand-side name is a renderable object in a GTO file The right-hand-side is the name of a material object in a GTO file.

### Container Assignment

The “contains” connection type indicates membership in a group or similar type of container object. The LHS is the group or container, the RHS is the object which is a member.

## Difference File Protocol

If the **object.protocol** property contains the string “difference” then the object contains difference data; the data is relative to some other reference file.

For example, for animated deforming geometry its advantageous to write a reference file for geometry in its natural undeformed state then write only the **points.position** property in a gto file per frame to store animation. The **difference** minor protocol can apply to any major protocol.

If a reference file and a difference for file it exists, you can reconstruct the file represented by the difference file using the `gtomerge` command. See Section gtomerge.

## Sorted Shell File Protocol

If the **object.protocol** property contains the string “sorted” and the object’s major protocol is **polygon** then the object contains sorted shell data.

This protocol guarantees that the vertices and elements of shells—isolated sections of polygonal geometry—will be continguous in the **points** and **elements** components of the object.

| | | |
|-|-|-|
| `shells` | The **shells** component is transposable. Each property in the component should have the same number of elements. | [Required Component] |
| `int[1][] shells.vertices` | The number of contiguous vertices that make up the Nth element’s shell. | [Required Property] |
| `int[1][] shells.elements` | The number of contiguous elements that make up the Nth element’s shell. | [Required Property] |

## Channels Protocol

This minor protocol declares data mapped onto geometric surfaces. Usually the data is mapped using one of the parameterizations found in the **mappings** component of polygonal or sub-d geometry or possibly using the natural parameterization of a surface as is often the case with NURBS.

Each declared channel appears as a `string[1] []` property of a **channels** component on the geometry. The name of the property is the name of the channel. The property should contain at least one element.

The first element of the property should indicate the name of the mapping to use. This is either the name of one of the properties in the **mappings** component or “natural” indicating that the natural parameterization of the surface should be used.

The second and subsequent elements should contain the name of data to map. This could be a texture map file on disk, an image object in the GTO file, or a special cookie string. The lack of second element can be used as a special cookie.

| | | |
|-|-|-|
| `channels` | The component holds the names of all the channels on the geometry. | [Required Component] |

### Example

Here is a cube with “color”, “specular”, and, “bump” channels assigned.

```
Object "cube" protocol "polygon"
     Component "points"
          Property float[3][8] "position"
     Component "elements"
          Property byte[1][8] "type"
          Property short[1][8] "size"
     Component "indices"
          Property int[1][32] "vertex"
          Property int[1][32] "st"
     Component "mappings"
          Property float[2][24] "st"
     Component "channels"
          Property string[1][2] "color"
          Property string[1][2] "specular"
          Property string[1][2] "bump"
```

The contents of the “channels” properties might be:

```
string[1] cube.channels.color = [ "st" "cube_color.tif" ]
string[1] cube.channels.specular = [ "st" "cube_specular.tif" ]
string[1] cube.channels.bump = [ "st" "cube_bump.tif" ]
```

## Animation Curve Protocol

The animation curve protocol defines a single component called **animation** in which each property holds an animation curve or data stream. The property’s interpretation string indicates how the data should be evaluated.

### Example

Here is a cube with animation curves.

```
Object "cube" protocol "polygon"
     Component "points"
          Property float[3][8] "position"
     Component "elements"
          Property byte[1][8] "type"
          Property short[1][8] "size"
     Component "indices"
          Property int[1][32] "vertex"
     Component "animation"
          Property float[6][2] "xtran" interpret as "bezier"
          Property float[6][2] "ytran" interpret as "bezier"
          Property float[6][2] "ztran" interpret as "bezier"
          Property float[6][5] "xrot" interpret as "bezier"
          Property float[6][8] "yrot" interpret as "bezier"
          Property float[6][10] "zrot" interpret as "bezier"
          Property float[1][100] "xscale" interpret as "stream"
```

<a name="footnote_1"></a> In version 1, the transform protocol’s object.globalMatrix property used to be of type `float[1] [16]`. This was a mistake that has been corrected in version 2. 2

<a name="footnote_2"></a> In version 3 of the **transform** protocol, the **object.parent** property is redundant and therefor deprecated. The **connection** protocol handles the transformation hierarchy information and in a much more elegant manner See Section Inter-Object.

<a name="footnote_3"></a> In version 1 of the polygon protocol, the **element.size** and **element.type** properties were combined into an **element.primitive** property. We felt that this was adding unnecessary complexity and because the primitive property was an int, it was taking up extra space.

<a name="footnote_4"></a> The indices component in a polygonal object contains values which are analogous to the RenderMan face varying type modifier.
