---
layout: default
title: Utilities
permalink: /rv/gto/utilities/
lang: en
---

# Utilities

## The `gtoinfo` Utility

Usage: `gtoinfo [OPTIONS] infile.gto`

Options:

| | |
|-|-|
| `-a/-all` | Output property data and header. |
| `-d/--dump` | Output property data (no header data is emitted). |
| `-l/--line` | Output property data one item per line. Can be used with either `-d` or `-s`. |
| `-h/--header` | Output header data. |
| `-s/--strings` | Output sting table data. |
| `-n/--numeric-strings` | Output sting data as the raw string id instead of the string itself. |
| `-i/--interpretation-strings` | Output interpretation string data for components and properties if it exists. |
| `-r/--readall` | Force reading of the enitre gto file even if only the header is being output. |
| `-f/--filter expression` | Only output information for properties who’s long name (object.component.propname) matches the shell-like *expression*. Section gtofilter for examples of filter expressions. This option is similar to `gtofilter --include` option. |
| `--help` | Output usage message. |

`gtoinfo` outputs the part of all of the contents of a gto file in human readable form. Its invaluable for debugging or just getting a quick understanding of what a gto file contains.

## The `gtofilter` Utility

Usage: &#8216;`gtofilter [OPTIONS] -o` *out.gto in.gto*’

Options:

| | |
|-|-|
| `-v` | Set verbose output. Whenever a pattern matches gtofilter will inform you. |
| `-ee/--exclude` | Regular expression which will be used to exclude properties. |
| `-ie/--include` | Regular expression which will be used to include properties. |
| `-regex` | Use POSIX regular expression syntax. |
| `-glob` | Use shell-like regular expression (fnmatch). This is the default. |
| `-t` | Output text GTO file. |
| `-nc` | Output uncompressed binary GTO file. |
| `-o` *out.gto* | Output .gto file |

`gtofilter` can be used to remove objects, components, and properties from a gto file. You supply an include shell-like expression and/or an exclude shell-like expression. (The pattern matching is done using the fnmatch() function—see the main page for details.)

The patterns match each full property name. So for example a cube might have these properties:

```
cube.points.position
cube.elements.type
cube.elements.size
cube.indices.vertex
cube.indices.st
cube.indices.normal
cube.normals.normal
cube.mappings.st
cube.smoothing.method
cube.object.globalMatrix
cube.object.parent
```

Using the `--exclude` option, you can remove the object component by doing this:

```
gtofilter --exclude "*.object.*" -o out.gto cube.gto
```

Or if you wanted to pass through only the positions:

```
gtofilter --include "*.*.positions" -o out.gto cube.gto
     -or-
gtofilter --include "*positions" -o out.gto cube.gto
```

## The `gtomerge` Utility

Usage: &#8216;`gtomerge` *-o outfile.gto infile1.gto infile2.gto ...*’

Options:

| | |
|-|-|
| `-o outfile.gto` | The resulting merged file to output. |
| `-t` | Ouput text GTO file. |
| `-nc` | Ouput uncompressed binary GTO file. |

`gtomerge` takes a number of .gto input files and merges them into a single output .gto file. This is done by first creating output geometry that is identical to the first input file and then adding only those properties that are not already defined from subsequent gto files. The order of input files determines what will be in the final output file.

For **difference** files, you can use gtomerge to reconstruct a final file like this:

`gtomerge -o out.gto difference.gto reference.gto`

## The `gto2obj` Utility

Usage: &#8216;`gto2obj [OPTIONS]` *infile outfile*’

Options:

| | |
|-|-|
| `-o NAME` | When outputing GTO files, the name of an object in the GTO file to output. If not specified, the translator will output the first polygon, or subdivision surface it finds. |
| `-c` | When outputing GTO files, this option will force the protocol to be “catmullclark”. |
| `-l` | When outputing GTO files, this option will force the protocol to be “loop”. |
| `-t` | Ouput text GTO file. |
| `-nc` | Output uncompressed binary GTO file. |

`gto2obj` takes either an input GTO file or Wavefront .obj file and outputs the other file type.

```
gto2obj in.obj out.gto
gto2obj in.gto out.obj
gto2obj -c in.obj out.gto ## output obj as subdivision surface
```

## The `gtoimage` Utility

Usage: &#8216;`gtoimage` infile outfile’

| | |
|-|-|
| `-t` | Ouput text GTO file. |
| `-nc` | Ouput uncompressed binary GTO file. |

`gtoimage` reads a TIFF file and converts it into a GTO file containing one image object. 32 bit floating point images, 16 bit and 8 bit integral images are directly converted. `gtoimage` expects the image to be two dimensional with three or four channels where the fourth channel is an optional alpha value. The output object conforms to the **image** protocol. See Section Image.

You can use `gtomerge` to merge the image object into another GTO file. See Section gtomerge.

It is highly recommend that the resulting output GTO file be written with compression or gzipped to reduce its size. Gzipped GTO files can be read directly by the supplied readers.

## The `RiGtoRibOut` Utility

The `RiGtoRibOut` command is useful for:

* It can be used as a debugging tool for the RiGtoPlugin RenderMan plugin.
* It can be used as a drop-in replacement for RiGtoPlugin, for RIB renderers that do not support `Procedural DynamicLoad`, but that *do* support `Procedural RunProgram`. Note that this is substantially slower than using RiGtoPlugin, as all data needs to be translated to ASCII and back. It does have the one space-saving advantage of not needing to save ASCII RIB on disk.
* It could be used to generate RIB files that are read with `ReadArchive`. This is not recommended, as it negates all the advantages of using GTO in the first place. But if nothing else works, this should.

The command-line parameters are the same as the *CONFIG STRING* for RiGtoPlugin. See Section RiGtoPlugin.

## The `gtoIO.so` Maya Plug-In

The Maya plugin comes in two parts: the C++ plugin which implements a Maya scene translator and an accompanying MEL script which implements the user interface.

The plugin handles export of NURBS surfaces (but not trim curves), polygonal geometry (which can be written as sub-division surfaces), and generic transforms. A Maya particle export tool is in the works. Additional user defined attributes can be emitted into the GTO file.

The plugin can import everything that it exports and also particle GTO files generated by other applications.

### BUGS

The internal performance of Maya has changed between the 4.x and 5.0 versions. In Maya 5.0, the Maya API is *extremely* slow when importing polygonal normals. Importing of normals is disabled in Maya 5.0.

## The RiGtoPlugin RenderMan plugin

Here you will find information on using the GTO RenderMan plugin. The documentation is complete enough to get started with, but should be considered a work in progress.

### RIB Instantiation

The plugin is instantiated in a RIB Stream using the standard DynamicLoad procedural mechanism, like so:

```
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "CONFIG_STRING" ] [ Bounding Box ]
```

If a bounding box is not known, the infinite box may be used:

```
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "CONFIG_STRING" ] [ -1e6 1e6 -1e6 1e6 -1e6
```

### Config String Syntax

The configuration string passed into RiGtoPlugin consists of a variable number of space-separated tokens. They are, in order:

1. Reference Pose GTO File Name
2. Shutter Open GTO File Name (optional)
3. Shutter Close GTO File Name (optional)
4. Primary On List (optional)
5. Primary Off List (optional)
6. Secondary On List (optional)
7. Secondary Off List (optional)

As shown, the only necessary element is the reference GTO file. For objects which do not have movement and do not require on lists or off lists, this is completely sufficient.

The logic behind the geometry instantiation mechanism is as follows:

* Read Reference GTO file The plugin reads all of the geometry in the reference GTO file. As a starting point, the shutter open and close geometry is set equal to the reference geometry.
* If requested, read Shutter Open GTO file The plugin then reads any geometry from the Shutter Open file that matches the name and geometry type of geometry that has already been read from the reference file—this geometry is stored as both the shutter open AND close geometry.
* If requested, read Shutter Close GTO file The plugin then reads any geometry from the Shutter Close file that matches the name and geometry type of geometry that has already been read from the reference file—this geometry is stored as the shutter close geometry
* Instantiate Geometry: For any piece of geometry that appears in BOTH on-lists and does not appear in EITHER off-lists, the plugin calls the appropriate RIB functions to create the requested geometry.

### On-List/Off-List Syntax

The syntax of the on-lists and off-lists is as follows:

`NULL` is a special on-list/off-list which is interpreted as *all on* or *none off*.

Otherwise, the on-lists and off-lists are essentially shell-like regular expressions. The following rules apply:

* The `*` character matches any number of characters
* The `?` character matches any single of character
* Bracket expressions `[]` are supported. (See `man 7 regex`)
* Multiple patterns can be strung together with the `|` character.
* The pattern must match the *whole* object name. Thus, the pattern “`*Sphere1`” will match the object `nurbsSphere1` but *not* `nurbsSphere1Shape`. This is a very common “gotcha”.

As an example, suppose you wanted to turn off all of the geometry named `LeftLeg*Shape*` and `RightLeg*Shape*` in a render—you would create an off-list that looked like:

```
"LeftLeg*Shape*|RightLeg*Shape*"
```

### Cache Management

By default, RiGtoPlugin maintains an internal cache of all of the file sets it has read. The cache is keyed off of Ref-Open-Close filename triplets. The reason for this is to facilitate easy material assignment, which will be discussed in greater detail below in the “Strategy” section.

In situations where memory is precious and the renderer needs as much memory as it can get, it may be advantageous to force RiGtoPlugin to discard its cached file sets. There is special syntax to facilitate this.

* To erase everything in RiGtoPlugin’s cache:

```
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "__FLUSH__" ] [ Bounding Box ]
```

* To erase the cache associated with a given file triplet: (Using REF.gto, OPEN.gto and CLOSE.gto as standins for whatever files were actually passed in)

```
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "REF.gto OPEN.gto CLOSE.gto __FLUSH__" ] [ Bounding Box ]
```

There is also an environment variable, `TWK_RI_GTO_NO_CACHE`, which if defined and set to anything other than “0”, “FALSE”, “False” or “false”, will cause caching to be disabled entirely.

### Environment Variables

| | | |
|-|-|-|
| `TWK_RI_GTO_NO_SUBDS` | If this environment variable is defined and set to anything except “0”, “FALSE”, “False”, or “false”, RiGtoPlugin will treat all catmull-clark subdivision surfaces read from a GTO file as polygons instead. | [Environment Variable] |
| `TWK_RI_GTO_NO_CACHE` | If this environment variable is defined and set to anything except “0”, “FALSE”, “False”, or “false”, RiGtoPlugin will disable all caching of geometry data to save memory. | [Environment Variable] |

### Usage Strategy

The RiGtoPlugin was designed with a particular data structure in mind. Used ideally, there would be a GTO file consisting of all of the geometry corresponding to a particular high-level creature or set in the scene. All of the surfaces corresponding to a hippo or a giraffe or a cyborg-monkey would be in a single GTO file. The animation data for this geometry would be contained in light-weight GTO files that contain only points that have moved and transformation matrices that have moved. The RiGtoPlugin only reads points and matrices from the Shutter-Open and Shutter-Close file, facilitating very light-weight “difference” files for animation data.

Because all of the geometry in a creature will have different materials assigned to it, on-lists and off-lists can be used to separate out only the geometry that shares a particular material.

Suppose we have a creature consisting of many surfaces but only three different materials—skinMtl, eyeMtl and hairMtl. The parts of the model have been named intelligently (for this example) such that the skin parts all have names like Skin&#42;Shape&#42;, the eye parts all have names like Eye&#42;Shape&#42;, and the hair parts all have names like Hair&#42;Shape&#42;. Then, the RIB for declaring this creature with material assignments might look like this:

```
AttributeBegin
Surface "skinShader" [ shader param settings ]
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "thing.ref.gtothing.0013.open.gto thing.0
AttributeEnd

AttributeBegin
Surface "hairShader" [ shader param settings ]
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "thing.ref.gtothing.0013.open.gto thing.0013.close.gto Hair*Shape*" ][-1e6 1e6 -1e6 1e6 -1e6 1e6]
AttributeEnd

AttributeBegin
Surface "eyeShader" [ shader param settings ]
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "thing.ref.gtothing.0013.open.gto thing.0013.close.gto Eye*Shape*" ][-1e6 1e6 -1e6 1e6 -1e6 1e6]
AttributeEnd
```

Because of RiGtoPlugin’s cache mechanism, the geometry associated with the file-set thing.&#42;.gto is only read and interpreted one time—the on-lists control which parts of the geometry are instantiated at which times. To nuke the cache of these files (if memory is important), you would use the syntax:

```
Procedural "DynamicLoad" [ "RiGtoPlugin.so" "thing.ref.gtothing.0013.open.gto thing.0
```

### Miscellaneous RenderMan Stuff

RiGtoPlugin stores some useful data in attributes that can be used by shaders if desired.

| | | |
|-|-|-|
| `Pref` | On ALL geometry RiGtoPlugin creates “varying point Pref” as part of its geometry declaration. This data can be accessed by simply putting “varying point Pref” in your shader parameters. The position of the model in the reference GTO file is always used for this parameter value. | [Shader parameter] |
| `Name` | RiGtoPlugin always places the name of the geometry, as retrieved from the GTO file, in an attribute that may be queried. It is exactly as if the following line of RIB were declared before the geometry were instantiated:<br/>`Attribute “identifier” “name” [“whatever my name is”]` | [RIB Attribute] |
| `RefToWorld` *matrix* | RiGtoPlugin places the transformation matrix *objectToWorld* from the reference model into a user attribute called `refToWorld`. To prevent this attribute from being munged by the current transformation matrix, it is cast as a float[16] instead of a matrix. It is equivalent to this line of RIB:<br/>`Attribute “user” “float refToWorld[16]” [ the matrix values ]` | [RIB Attribute] |
