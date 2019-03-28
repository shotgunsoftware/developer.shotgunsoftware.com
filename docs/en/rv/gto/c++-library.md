---
layout: default
title: GTO: C++ Library
permalink: /rv/gto/c++-library/
lang: en
---

# C++ Library

The GTO Reader/Writer library is written in a subset of C++. The intention was to make the library as portable as possible. Unfortunately we have only tried it on platforms that support gcc 2.95 and greater. It is known to work on various Linux versions and Mac OS X. In either case it has been compiled with gcc.

## Gto::Reader class

The Reader class (in namespace Gto) is designed as a fill-in-the-blank API. The user of the class derives from it; the base class defines a number of virtual functions which pass data to the derived class and ask the derived class questions about what data it wants.

The Reader class handles most of the difficult work in reading the file like keeping track of headers, sizes of properties, and the order of data. In addition, it handles the string table and looking up property string values. If the file was written by a machine with different sex (endianess) it will translate the data for you.

In addition, you can compile the GTO library with zlib support. This enables the Reader class to read gzipped GTO files natively and the Writer class to write them. This can be a significant space savings on disk and on saturated networks can make file loading faster. You can also pass a C++ istream object to the Reader if you want to read “in-core”.

As the file is read, the Reader class will call its virtual functions to declare objects in the file to the derived class. The derived class is expected to return a non-null pointer if it wishes to later receive data for that object.

| | | |
|-|-|-|
| `Reader::Reader` *(unsigned int `mode`)* | The constructor argument mode indicates how the reader will be used. This value is a bit vector of the following or’ed flags:<br/>     **`Reader::None`**<br/>     The reader will be used in its standard *streaming* mode. The reader will attempt to read all the data in the file. This is the default value (or 0).<br/>     **`Reader::HeaderOnly`**<br/>     The reader will stop once it has read the header sections of the GTO file. This is an optimization that applies to binary files only. This option is ignored when reading a text file.<br/>     **`Reader::RandomAccess`**<br/>     The reader will read the header sections but not the data, however, it will initialize for use of the `Reader::accessObject()` function. Only binary GTO files can be read using the random access mode.<br/>     **`Reader::BinaryOnly`**<br/>     Only binary GTO files will be accepted by reader.<br/>     **`Reader::TextOnly`**<br/>     Only text GTO files will be accepte by reader. | [Constructor] |
| `Reader::~Reader ()` | Closes file if still open. | [Destructor] |
| `bool Reader::open` *(const char&#42; `filename`)* | Open the file. The Reader will attempt to open file filename. If the file does not exist and zlib support is compiled in, the Reader will attempt to look for filename.gz and open it instead. | [Method] |
| `bool Reader::open` *(std::istream&, const cha&#42;* `name`)* | Reads the GTO file data from a stream. The *name* is supplied to make error messages make sense. | [Method] |
| `void Reader::close ()` | Close the file and clean up temporary data. If the stream constructor was used, the stream is *not* closed. | [Method]      |
| `std::string& Reader::fail` *(std::string `why`)* | Sets the error condition on the Reader and sets the human readable reason to *why*. | [Method] |
| `std::string& Reader::why ()` | Returns a human readable description of why the last error occured. (Set by the `fail()` function). | [Method] |
| `const std::string& Reader::stringFromId` *(unsigned int)* | Given a string identifier, this method will return the actual string from the string table. | [Method]      |
| `const StringTable& Reader::stringTable ()` | Returns a reference to the entire string table. | [Method]      |
| `bool Reader::isSwapped ()` *const* | Returns true if the file being read needed to be swapped. This occurs if the machine the file was written on is a different sex than the machine reading the file (for example a Mac PPC written file read on an x86 GNU/Linux box). | [Method] |
| `unsigned int Reader::readMode ()` *const* | Returns the mode value passed into the Reader constructor. | [Method] |
| `const std::string& Reader::infileName ()` *const* | Returns the name of the file or stream being read. This is the value passed in to the `Reader::open()` function. | [Method] |
| `std::istream* Reader::in ()` *const* | Return the input stream created by or passed into `Reader::open()`. If the GTO file is compressed binary, this function will return NULL. | [Method] |
| `int Reader::linenum ()` *const* | For text GTO files, the return value will be the current line being parsed. For binary GTO files, the return value is always 0. | [Method] |
| `int Reader::charnum ()` *const* | For text GTO files, the return value will be the current char column (in the current line) being parsed. For binary GTO files, the return value is always 0. | [Method] |
| `Header& Reader::fileHeader ()` *const* | Returns a reference to a Gto::Header structure corresponding to the file currently being read. This function is required by the text file parser. The function may disappear from future versions. See the `Reader::header()` function below for a better way to get header information. | [Method] |

The following functions are called by the base class.

| | | |
|-|-|-|
| `void Reader::header` *(const `Header& header`)* | This function is called by the Reader base class right after the file header has been read (or created). | [Virtual] |
| `void Reader::descriptionComplete ()` | This function is called after all file, object, component, and property structures have been read. For binary files, this is just before the data is read. For text files, this is after the entire file has been read. | [Virtual] |

The following functions return a `Reader::Request` object. This object takes two parameters: a boolean indicating whether the data in question should be read by the reader and a second optional data `void*` argument of user data to associate with the file data.

| | | |
|-|-|-|
| `Reader::Request::Request` *(bool `want`, void&#42; `data`)* | *want* value of true indicates a request for the data in question. *data* can be any void&#42;. *data* is meaningless if the *want* is false. | [Constructor] |
| `Reader::Request Reader::object` *(const std::string& `name`, const std::string& `protocol`, unsigned int `protocolVersion`, const ObjectInfo& `header`)* | This function is called whenever the Reader base class encounters an ObjectHeader. The derived class should override this function and return a Request object to indicate whether data should be read for the object in question. If it requests not to have data read, the Reader will not call the corresponding component() and property() functions. | [Virtual]     |
| `Reader::Request Reader::component` *(const std::string& `name`, const  ComponentInfo& `header`)* | This function is called when the Reader base class encounters a ComponentHeader in the GTO file. If the derived class did not express interest in a particular object in the file by returning `Request(false)` from the object() function, the components of that object will not be presented to the derived class. The derived class should return `Request(true)` to indicate that it is interested in the properties of this *component*. | [Virtual] |
| `Reader::Request Reader::property` *(const std::string& `name`, const  char* `interpString`, const PropertyInfo& `header`)* | This function is called when the Reader base class encounters a PropertyHeader in the GTO file. If the derived class did not express interest in a particular object or the component that the property belongs to, the properties of that component will not be presented to the derived class. The derived class should return `Request(true)` to indicate it is interested in the property data. | [Virtual] |
| `void* Reader::data` (const PropertyInfo&, size&#95;t `byts`) | This function is called before property data is read from the GTO file. The function should return a pointer to memory of at least size bytes into which the data will be read. The type, size, width, etc, of the data can be obtained from the `PropertyInfo` structure. | [Virtual] |
| `void Reader::dataRead` *(const PropertyInfo&)* | This function is called after the `data()` function if the data was successfully read. | [Virtual] |

If you are using the Reader class in `Reader::RandomAccess` mode, you may call these functions after the read function has returned:

| | | |
|-|-|-|
| `Reader::Objects& Reader::objects ()` | Returns a reference to an std::vector of Reader::ObjectInfo structures. These are only valid after `Reader::open()` has returned. You can use these structures when calling `Reader::accessObject()`. | [Method] |
| `const Reader::Components& Reader::components ()` | Returns a reference to an std::vector of Reader::ComponentInfo structures. These are only valid after `Reader::open()` has returned. This method is most useful when deciding how to call the `accessObject` function. | [Method]  |
| `const Reader::Properties& Reader::properties ()` | Returns a reference to an std::vector of Reader::PropertyInfo structures. These are only valid after `Reader::open()` has returned. This method is most useful when deciding how to call the `accessObject` function. | [Method]  |
| `Reader::Request Reader::property` *(const std::string& `name`, const  char* `interpString`, const PropertyInfo& `header`)* | This function is called when the Reader base class encounters a PropertyHeader in the GTO file. If the derived class did not express interest in a particular object or the component that the property belongs to, the properties of that component will not be presented to the derived class. The derived class should return `Request(true)` to indicate it is interested in the property data. | [Method] |
| `void Reader::accessObject` *(const ObjectInfo&)* | Calling this function on a GTO file opened for `RandomAccess` reading will cause the reader to seek into the file just for the data related to the object passed in. This is most useful when the objects’ data cannot be held in memory and the order of retrieval is unknown. The reader attempts to be efficient as possible without using too much | [Virtual] |

## Gto::Writer class

The Writer class (in namespace Gto) is designed as an API to a state machine. You indicate a conceptual hierarchy to the file and then all the data. The writer handles generating the string table, the header information, etc.

The following is an example that outputs a polygon cube using the **polygon** protocol.

```
float points[3][] =
{ { -2.5, 2.5, 2.5 }, { -2.5, -2.5, 2.5 },
     { 2.5, -2.5, 2.5 }, { 2.5, 2.5, 2.5 },
     { -2.5, 2.5, -2.5 }, { -2.5, -2.5, -2.5 },
     { 2.5, -2.5, -2.5 }, { 2.5, 2.5, -2.5 } };

unsigned char type[] = { 2, 2, 2, 2, 2, 2 };
unsigned char size[] = { 4, 4, 4, 4, 4, 4 };

int indices[] = {0, 1, 2, 3, 7, 6, 5, 4,
          3, 2, 6, 7, 4, 0, 3, 7,
          4, 5, 1, 0, 1, 5, 6, 2 };

Gto::Writer writer;
writer.open("cube.gto");

writer.beginObject("cube", "polygon", 2); // polygon version 2

     writer.beginComponent("points");
          // will write 8 float[3] positions
          writer.property("positions", Gto::Float, 8, 3);
     writer.endComponent();

     writer.beginComponent("elements");
          // one per face
          writer.property("size", Gto::Short, 8, 1, 1);
          writer.property("type", Gto::Byte, 8, 1, 1);
     writer.endComponent();

     writer.beginComponent("indices");
          // one per vertex per face
          writer.property("vertex", Gto::Int, 24, 1, 1);
     writer.endComponent();

writer.endObject();

// repeat writer object blocks if more objects

// output all the data in order declared

     writer.beginData();
     writer.propertyData(type);
     writer.propertyData(size);
     writer.propertyData(indices);
     writer.endData();
```

| | | |
|-|-|-|
| `Writer::Writer ()` | Creates a new Writer class object. Typically you’ll make one of these on the stack. This constructor requires you call the open function to actually start writing the file. | [Constructor] |
| `Writer::Writer` *(std::ostream&)* | Creates a new Writer class object which will output to the passed C++ output stream. | [Constructor] |
| `Writer::~Writer ()` | Closes file opened with the `open()` function if still open. The destructor will not close any passed in output stream. | [Destructor]  |
| `bool Writer::open` *(const char* `filename`, FileType `mode` =  CompressedGTO)* | Open the file. The Writer will attempt to open file *filename*. If the file is not writable for whatever reason, the function will return false. If *mode* is `CompressedGTO` (the default value), the Writer class will output a binary compressed file. If the value is `BinaryGTO` the file will be binary uncompressed. If *mode* is `TextGTO` a text GTO file will be written. Compressed GTO files can be uncompressed manually using `gzip`. Compression is available only if the library is compiled with zlib support. | [Method] |
| `bool Writer::open` *(const char&#42; `filename`, bool compress = `true`)* | This function exists for backwards compatibility. Use the other `open()` function instead. This function can open a file for binary output only (it cannot write a text GTO file). | [Method] |
| `void Writer::close ()` | Close the file and clean up temporary data. If the stream constructor was used, the stream is *not* closed. | [Method] |
| `void Writer::beginObject` *(const char&#42; `name`, const char&#42; `protocol`,  unsigned int `version`) const* | Declares an object. Its components and properties must be declared before `endObject()` is called. The *name* is the name of the object as it will appear in the gto file. The *protocol* is the protocol string indicating how the object data will be interpreted and the *version* number indicates the protocol version. The Writer class does not verify that the data output conforms to the protocol. | [Method] |
| `void Writer::beginComponent` *(const char&#42; `name`, bool  `transposed`=false)* | Declares a component. The component properties must be declared before a call to endComponent(). The *name* is the name of the component as it will appear in the gto file. The *transposed* flag is optional and indicates whether or not the component property data should be output transposed or one property at a time (the default). | [Method] |
| `void Writer::property` *(const char&#42; `name`, Gto::DataType `type`, size&#95;t `numElements`, size&#95;t `partsPerElement`=1, const char&#42; `interpString`=0)* | Declare a property. The *name* is the name of the property as it appears in the gto file. The *type* is one of `Gto::Double`, `Gto::Float`, `Gto::Int`, `Gto::String`, `Gto::Byte`, `Gto::Half`, or `Gto::Short`. *numElements* indicates the number of elements of size *partsPerElement* that will be in the property data. So for example, if the property is declared as a Gto::Float of with *partsPerElement* of 3 and there 10 of them, then the writer will expect an array of 30 floats when the propertyData is finally passed to it. The last argument *interpString* is an optional interpretation string that can be stored with the property. | [Method] |
| `void Writer::endComponent ()` | Closes the declaration of a component started by `beginComponent()`. | [Method]      |
| `void Writer::endObject ()` | Closes the declaration of an object started by `beginObject()`. | [Method] |
| `void Writer::intern` *(const char&#42; `string`)* | Declares a string to the Writer for inclusion in the file string table. When writing properties of type `Gto::String`, its necessary to call this function before the `beginData()` is called. Each string in the property data must be interned. When outputing the property, the property will be an array of `Gto::Int` in which each int is the result of the `lookup()` function which retrieves a unique int corresponding to interned strings. | [Method] |
| `void Writer::intern` *(const std::string& `string`)* | Same as above, but takes an `std::string`. | [Method] |
| `int Writer::lookup` *(const char&#42; `string`)* | Retrieve the identifier of the previously interned string *string*. | [Method] |
| `int Writer::lookup` *(const std::string& `string`)* | Same as above, but takes an `std::string&`. | [Method] |
| `void Writer::beginData ()` | Begins data declaration to the Writer class. Only calls to `lookup()`, `propertyData()`, `propertyDataInContainer()`, and `endData()` are legal after `beginData()` is called. | [Method] |
| `void Writer::propertyData` *(const TYPE&#42; `type`)* | `propertyData()` is a template function which takes a pointer to continuously stored data. The data must be the same as declared earlier by the `property()` function. Calls to `propertyData()` and `propertyDataInContainer()` must appear in the same order as the `property()` declarations calls. | [Method] |
| `void Writer::propertyDataInContainer` *(const TYPE& `container`)* | `propertyDataInContainer()` is a template function which takes an stl-like container as an argument. The data must be the same as declared earlier by the `property()` function. Calls to `propertyData()` and `propertyDataInContainer()` must appear in the same order as the `property()` declarations calls. This function is a convenience function; it calls `propertyData()` to actually output the data. This function may make a copy of the data in the container. | [Method] |
| `void Writer::endData ()` | Closes the definition of data started by `beginData()` and finishes writing the gto file. | [Method] |

## Gto::RawDataReader/Gto::RawDataWriter classes

These classes provide a quick method of reading the contents of a GTO file into memory for basic editing. The RawDataReader and RawDataWriter both use the same very primitive data structure that can be found in the RawData.h file. For examples of use, see `gtomerge` and `gtofilter` source code.

The RawData class shows how to both read and write using the supplied classes. In addition the reader subclass shows how to convert string data.
