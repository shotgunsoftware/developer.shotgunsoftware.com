---
layout: default
title: GTO: Text Format
permalink: /rv/gto/text-format/
lang: en
---

# Text Format

As of version 3.2, GTO has a text representation in addition to the binary representation. The text representation is designed for human use; it is intended to be easy to modify or create from scratch in a text editor. It is not intended to compete with XML formats (which are typically only human readable in theory) nor is it intended to be used in place of the binary format which is much faster and more economical for storage of large data sets.

## Example of a Cube Stored as a Text GTO

Here’s the example from the overview section: a cube stored using the “polygon” protocol:

```
GTOa (4)
# this is a comment
cube : polygon (2)
{
points
{
float[3] position = [ [ -2.5 2.5 2.5 ]
[ -2.5 -2.5 2.5 ]
[ 2.5 -2.5 2.5 ]
[ 2.5 2.5 2.5 ]
[ -2.5 2.5 -2.5 ]
[ -2.5 -2.5 -2.5 ]
[ 2.5 -2.5 -2.5 ]
[ 2.5 2.5 -2.5 ] ]
float mass = [ 1 1 1 1 1 1 1 1 ]
}
elements
{
byte type = [ 2 2 2 2 2 2 ]
short size = [ 4 4 4 4 4 4 ]
}
indices
{
int vertex = [ 0 1 2 3
7 6 5 4
3 2 6 7
4 0 3 7
4 5 1 0
1 5 6 2 ]
}
}
```

The first line of the file is an identifier to tell the parser what variety of GTO file it is: in this case GTOa which indicates a plain ASCII text file. Currently the parser can only handle ASCII encoding; a forthcoming version will allow UTF-8.

Objects are declared using the syntax:

```
OBJECTNAME [ : PROTOCOL [ (PROTOCOL_VERSION) ] ]
{
... object contents ...
}
```

The brackets enclose optional syntax. So the `PROTOCOL_VERSION` (including the parents) is optional. The `PROTOCOL` is also optional; if omitted (along with the colon) the protocol defaults to object. In the example, “cube” is the name of the object and “polygon” is the name of the protocol–the protocol version is 2.

Components must be declared inside the object brackets or other components. The brackets denote a *namespace* which is either an object namespace or a component namespace. Component namespaces must always be declared inside of an object or component namespace. Object namespaces can only appear at the top level of the file; in other words, objects cannot be inside another namespace.

Components are declared like this:

```
COMPONENTNAME [as INTERPRETATION]
{
  ... component contents ...
}
```

The INTERPRETATION can be any string. Properties can be declared inside of the component namespace optionally followed by nested component declarations. The property declaration is the most flexible; since some aspects of the property (like its size) can be determined by the parser from the property data, you can omit them.

The property syntax in its most general form is:

```
TYPE[XS,YS,ZS,WS][SIZE] PROPERTYNAME as INTERPRETATION = values ...
```

The brackets around `XS,YS,ZS,WS` and `SIZE` are literal in this case; they actually appear in the file. As you can see from the example, some of the property declaration syntax is optional. The `SIZE` can usually be determined from the values so it may be omitted. The dimensions are assumed to be `1` (or scalar) if it is omitted. The as `INTERPRETATION` section of the declaration may also be omitted.

What cannot be omitted is the `TYPE, PROPERTYNAME,` and the assignment of values.

## How Strings are Handled in the Text Format

With the exception of keywords and type names, any string in the text GTO file can be either be quoted or non-quoted. Non-quoted strings are restricted to strings which do not represent numbers. In addition, if a string contains punctuation or whitespace, it must be quoted. For example, if the name of the object in the cube example was “four dimensional time-cube” it would have to be declared like this:

```
"four dimensional time-cube" : polygon
{
...
}
```

There is one additional exception: if a string is also a keyword or type name, it must be quoted. For example, here’s an exceptional property declaration:

```
int "int" as "as" = 1
```

In this case the quoted string “int” is being used as the property name, but because it is also the name of a GTO type, it must be quoted. The string “as” is being used as an interpretation string and must be quoted because “as” is also a keyword in the the GTO file.

When in doubt quote.

## Value Brackets

Generally, a property value and elements of the value are enclosed in brackets:

```
TYPE[DIMENSIONS] PROPERTYNAME = [ [a b ...] [d e ...] ... ]
```

In this documentation, the *value* of a property is everything to the right of the “=” and an *element* is a fixed size collection of numbers or strings. The *size* of a property is the number of elements in its value. So in the example above, the `[a b ...]` portion of the syntax is an *element*.

Bracketing the property value is optional in one circumstance: when the number of elements in the property value is one. For example, these declarations are equivalent:

```
int foo = 1
int foo = [1]
```

If the width of the type is not one (elements are not scalar), then brackets must be put around each element of the property. If the size is one but the width is not one, then the enclosing brackets are still optional:

```
int[2] foo = [1 2]
int[2] foo = [ [1 2] ]
```

If however the size of the property is greater than one, the enclosing value brackets are required:

```
# property of size 3
int[2] foo = [ [1 2] [3 4] [5 6] ]
```

To declare a property with no value use empty brackets:

```
int foo = []
```

## The Size of a Property

The size of a property can be declared as part of its type declaration:

```
int[1][4] foo = [1 2 3 4]
```

In this case, “foo” contains four scalar elements. Because the size was specified, the following would be a syntax error:

```
int[1][4] foo = [1 2 3 4 5]
```

The parser would complain because five elements were supplied even though the property was declared as having only four. If no size is specified than the parser will determine the size from the number of elements in the value:

```
int[1] foo = [1 2 3 4 5]
```

So in this case “foo” has five elements. Note that in order to declare the size specifically, you must also declare the element width—even if the width is one. In the last example, because we did not specify the size, the declaration could also have been:

```
int foo = [1 2 3 4 5]
```

In this case it is understood that the type is actually `int[1][5].`

Additional dimensions can be added to make e.g. a matrix:

```
float[4,4] M = [1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1]
```

This can be extended up to four dimensions:

```
byte[4,1920,1080] eightBit1080pImage = [ ... ]
float[3,32,32,32] floatingPoint3DLUT = [ ... ]
```

## Run Length Encoding of Values

In some cases, a value will contain many copies of an element. There is a special syntax for these cases; you can use an ellipsis to indicate that all remaining elements are identical. The ellipsis can only appear directly before the final bracket character.

There is one restriction when using this syntax: the type of the property value must be completely specified (including the size of the property) and the value must be enclosed in brackets. For example:

```
int[1][100] mass = [1 ...]
```

The ellipsis is literal (its actually in the file as three dot characters) The property “mass” will be one for all 100 elements. If the element has a width greater than one:

```
float[3][100] velocity = [ [0 0 0] ... ]
```

The ellipsis is used in place of an element. The following will *not* work:

```
float[3][100] velocity = [ [0 ...] ... ]
```

The intention here is to make all of the velocity elements `[0 0 0]`. However, this syntax is not correct and will produce a parsing error.

## Syntax Reference

The grammar for the text GTO file. *INT* is an integer constant. *FLOAT* is a floating point constant, with a possible exponent part. *STRING* is either a quoted or non-quoted string. All other values are literal. Double quoted strings are keywords.

```
file::
     "GTOa" object_list
     "GTOa" ( INT ) object_list

object_list::
     object
     object_list object

object::
     STRING { component_list_opt }
     STRING : STRING { component_list_opt }
     STRING : STRING ( INT ) { component_list_opt }

component_list_opt::
     nothing
     component_list

component_list::
     component
     component_list component

component_block::
     nothing
     property_list
     component_list
     property_list component_list

interp_string_opt::
     nothing
     "as" STRING

component::
     STRING interp_string_opt { component_block }

property_list::
     property
     property_list property

property::
     type STRING interp_string_opt = atomic_value
     type STRING interp_string_opt = [ complex_element_list ]

dimensions::
     INT
     INT "," INT
     INT "," INT "," INT
     INT "," INT "," INT "," INT

type::
     basic_type
     basic_type [ dimensions ]
     basic_type [ dimensions ] [ INT ]

basic_type::
     "float" "int" "string" "short" "byte" "half"
     "bool" "double"

complex_element_list::
     nothing
     element_list
     element_list "..."

element_list::
     element
     element_list element

element::
     atomic_value
     [ atomic_value_list ]

atomic_value_list::
     string_value_list
     numeric_value_list

atomic_value::
     string_value
     numeric_value

string_value_list::
     string_value
     string_value_list string_value

string_value::
     STRING

numeric_value_list::
     numeric_value
     numeric_value_list numeric_value

numeric_value::
     float_num
     int_num

float_num::
     FLOAT
     - FLOAT

int_num::
     INT
     - INT
```
