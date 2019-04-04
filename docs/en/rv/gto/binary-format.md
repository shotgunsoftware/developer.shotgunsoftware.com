---
layout: default
title: Binary Format
permalink: /rv/gto/binary-format/
lang: en
---

# Binary Format

The GTO file has six major sections which appear in the following order.

1. **Header** (Gto::Header). The header structure contains the GTO magic number (used to determine endianness), the version of the GTO specification that the file was written as, and the number of top level objects in the file. There is one instance of a header in the file. Finally, the header indicates how many strings are in the string table.

```
Magic = 0x0000029f; Cigam = 0x9f020000; // means the file is opposite
endianess

struct Header

{
  uint32 magic;
  uint32 numStrings;
  uint32 numObjects;
  uint32 version;
  uint32 flags; // reserved;
};
```

2. **String Table**. After the header, null terminated strings are written in the file. The order of these strings is important. All names and string properties store indices into the string table instead of actual strings. In order to read the file properly, the string table must be available until the file is completely read. (Unless you don’t care about any strings!)

   The index number refers the string number in the table not its byte offset. So the string index 9 (for example) refers to the 10th string in the table (string index 0 is the first string in the table).

3. **ObjectHeader** (Gto::ObjectHeader). The object header indicates what kind of protocol to use to interpret it, the **object** name and the number of components. (More on the object protocol later). The name—like all strings in the GTO file—is stored as a string table entry. If the file header indicated N objects in the file, there will be N ObjectHeaders.

```
struct ObjectHeader
{
uint32 name; // a string table index
uint32 protocolName; // a string table index
uint32 protocolVersion;
uint32 numComponents;
uint32 pad; // unused
};
```

4. **ComponentHeader** (Gto::ComponentHeader). Like the ObjectHeaders the ComponentHeaders will appear together for all objects in order. The component header indicates the number of properties in the component and the name of the component.

```
enum ComponentFlags
{
Transposed = 1 << 0,
Matrix = 1 << 1,
};
struct ComponentHeader
{
uint32 name; // a string table index
uint32 numProperties;
uint32 flags;
uint32 interpretation; // a string table index
uint32 childLevel; // nesting level
};
```

5. **PropertyHeader** (Gto::PropertyHeader). The PropertyHeaders, like the object and component headers, appear en masse in the file. The PropertyHeader contains the name, size, type, and dimension of the property.
```
enum DataType
{
Int, // int32
Float, // float32
Double, // float64
Half, // float16
String, // string table indices
Boolean, // bit
Short, // uint16
Byte // uint8
};
struct Dimensions
{
uint32 x;
uint32 y;
uint32 z;
uint32 w;
}
struct PropertyHeader
{
uint32 name; // string table index
uint64 size;
uint32 type; // DataType enum value
Dimensions dims;
uint32 interpretation; // string table index
};
```

6. **Data**. The last section of the file contains all of the property data. The beginning and end of a properties data are not marked. The size must be consistent with the description of the property used in the PropertyHeader.

In (Text) diagram form the file looks something like this:

+--------------------+
|    File Header     |
+--------------------+
|    String Table    |
+--------------------+
|    Object Header   |
|         .          |
|         .          |
|         .          |
+--------------------+
|  Component Header  |
|         .          |
|         .          |
|         .          |
+--------------------+
|  Property Header   |
|         .          |
|         .          |
|         .          |
+--------------------+
|    Property Data   |
|         .          |
|         .          |
|         .          |
+--------------------+
