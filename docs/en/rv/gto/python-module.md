---
layout: default
title: GTO: Python Module
permalink: /rv/gto/python-module/
lang: en
---

# Python Module

The gto module implements a reader/writer library for the Python language. The module is implemented on top of the C++ reader and writer classes. The API is similar to the C++ API, but takes advantage of Python’s dynamic typing to “simplify” the design. The Python module also implements a significant number of safety checks not present in the C++ library, making it an ideal way of exploring the Gto file format.

## gto.Reader

The Reader class is designed as a fill-in-the-blank API much like the C++ library. The user of the class derives from it; the base class defines a number of functions which you override to pass data to the derived class and receive data from it.

As the file is read, the Reader class will call specific functions in itself to declare objects in the file. The derived class is handed data or asked to return whether or not it is interested in specific properties in the file.

The biggest difference from the C++ Reader class is that the `data()` method of the C++ class, which returns allocated memory for the library to read data into, cannot be overloaded in Python. Instead, the `dataRead()` method of the Python gto.Reader class is handed pre-allocated Python objects containing the data.

| | | |
|-|-|-|
| *status* `gto.Reader` *(mode)* | Create a new gto.Reader instance. Possible values for *mode*:<br/>**gto.Reader.NONE**<br/>     The reader will be used in its standard *streaming* mode. The reader will attempt to read all the data in the file. This is the default value (or 0).<br/>**gto.Reader.HEADERONLY**<br/>     The reader will stop once it has read the header sections of the GTO file.<br/>**gto.Reader.RANDOMACCESS**<br/>     The reader will read the header sections but not the data, however, it will initialize for use of the `gto.Reader.accessObject()` method.<br/>**gto.Reader.BINARYONLY**<br/>     The reader will only accept binary GTO files.<br/>**gto.Reader.TEXTONLY**<br/>     The reader will only accept text GTO files. | [Constructor] |
| `gto.Reader.open` *(filename)* | Opens and reads the GTO file *filename*. The function will raise a Python exception if the file cannot be opened. | [Method] |
| *wants* `gto.Reader.object` *(name, `protocol`, `protocolVersion`, `objectInfo`)* | This function is called by the base class to declare an object in the GTO file. The return value *wants* should evaluate to True or False, indicating whether or not the base class should read the object data. *name* and *protocol* are strings declaring name and protocol of the object, *protocolVersion* is an integer. *objectInfo* is an instance of a generic class which contains the same information as the Gto::ObjectInfo C++ struct. | [Method] |
| *wants* `gto.Reader.component` *(name, `interpretation`,  `componentInfo`)*       | This function is called by the base class to declare a component in the GTO file. The return value *wants* should evaluate to True or False, indicating whether or not the base class should read the component data. *name* is a string declaring the component name. *componentInfo* is an instance of a generic class which contains the same information as the Gto::ComponentInfo C++ struct. | [Method] |
| *wants* `gto.Reader.property` *(name, `interpretation`, `propertyInfo`)* | This function is called by the base class to declare a property in the GTO file. The return value *wants* should evaluate to True or False, indicating whether or not the base class should read the property data. *name* is a string declaring the full property name. *propertyInfo* is an instance of a generic class which contains the same information as the Gto::PropertyInfo C++ struct. | [Method] |
| `gto.Reader.dataRead` *(name, data, propertyInfo)* | If a property has been requested, the dataRead() function will eventually be called by the base class with the actual data in the file. The *name* is the name of a property, *data* is a tuple containing the property data, *propertyInfo* is an instance of a generic class which contains the same information as the Gto::PropertyInfo C++ struct. | [Method] |
| `gto.Reader.stringFromID` *(id)* | Returns the stringTable entry for the given string table id. Since the Python gto module returns strings directly, it is unlikely that you’ll need to use this. | [Method] |
| `gto.Reader.stringTable ()` | Returns the entire stringTable as a list of strings. | [Method] |
| `gto.Reader.isSwapped ()` | Returns True if the file on disk is not in the machine’s native byte order. | [Method] |
| `gto.Reader.objects ()` | Returns a list of the gto.ObjectInfo instances for all the objects in the file. This method is only available if the file was opened with gto.Reader.RANDOMACCESS. Usable at any time after the constructor is called. | [Method] |
| `gto.Reader.components ()` | Returns a list of the gto.ComponentInfo instances for all the components in the file. This method is only available if the file was opened with gto.Reader.RANDOMACCESS. Usable at any time after the constructor is called. | [Method] |
| `gto.Reader.properties ()` | Returns a list of the gto.PropertyInfo instances for all the properties in the file. This method is only available if the file was opened with gto.Reader.RANDOMACCESS. Usable at any time after the constructor is called. | [Method] |
| `gto.Reader.accessObject` *(objInfo)* | Given an instance of gto.ObjectInfo (obtained via gto.Reader.objects(), gto.Reader.components(), or gto.Reader.properties()), tells the reader to access that object directly. This will cause the gto.Reader.object(), gto.Reader.component(), and gto.Reader.dataRead() methods to be called with the information from the given object. | [Method] |

## gto.Writer

| | | |
|-|-|-|
| `gto.Writer ( )` | Creates a new writer instance, no arguments needed. | [Constructor] |
| `gto.Writer.open` *(filename, mode)* | Open the file. The Writer will attempt to open file *filename*. If the file is not writable for whatever reason, the function will raise a Python exception. The *mode* argument can be `BINARYGTO`, `COMPRESSEDGTO` (the default) or `TEXTGTO`. | [Method] |
| `gto.Writer.close ( )` | Close the file and clean up temporary data. Because of Python’s garbage-collection, you can never be sure when a class’s destructor will be called. Therefore, it is *highly* recommended that you call this method to close your file when it’s done writing. You have been warned. | [Method] |
| `gto.Writer.beginObject` *(name, protocol, version)* | Declares an object. Its components and properties must be declared before endObject() is called. The *name* is the name of the object as it will appear in the gto file. The *protocol* is the protocol string indicating how the object data will be interpreted and the *version* number indicates the protocol version. The Writer class does not verify that the data output conforms to the protocol. | [Method] |
| `gto.Writer.beginComponent` *(name, interpretation, transposed)* | Declares a component. The component properties must be declared before a call to endComponent(). The *name* is the name of the component as it will appear in the gto file. The *transposed* flag is optional and indicates whether or not the component property data should be output transposed or one property at a time (the default). | [Method] |
| `gto.Writer.property` *(name, type, numElements, partsPerElement, interpretation)* | Declare a property. The *name* is the name of the property as it appears in the gto file. The *type* is one of gto.DOUBLE, gto.FLOAT, gto.INT, gto.STRING, gto.BYTE, gto.HALF (*Not implemented*), or gto.SHORT. *numElements* indicates the number of elements of size *partsPerElement* that will be in the property data. So for example, if the property is declared as a gto.FLOAT of with *partsPerElement* of 3 and there 10 of them, then the writer will expect a sequence of 30 floats when the propertyData is finally passed to it. | [Method] |
| `gto.Writer.endComponent ()` | Closes the declaration of a component started by beginComponent(). | [Method] |
| `gto.Writer.endObject ()` | Closes the declaration of an object started by beginObject(). | [Method] |
| `gto.Writer.intern` *(string)* | Declares a string to the Writer for inclusion in the file string table. When writing properties of type gto.String, its necessary to call this function for each string in the property data before the beginData() is called. The Python version of intern() can accept individual strings, as well as lists or tuples of strings. | [Method] |
| `int gto.Writer.lookup` *(string)* | Retrieve the identifier of the previously interned string. Valid only after beginData() has been called. | [Method] |
| `gto.Writer.beginData ()` | Begins data declaration to the Writer class. Only calls to lookup(), propertyData(), and endData() are legal after beginData() is called. | [Method] |
| `gto.Writer.propertyData` *(data)* | The propertyData() function must get exactly *one* parameter. That parameter can be any of the following:<br/>• A single int, float, string, etc.<br/>• An instance of mat3, vec3, mat4, vec4, or quat (http://cgkit.sourceforge. net / ). DO NOT explicitly cast mat3 or mat4 into a tuple or list: `tuple(mat4(1))`. It will be silently transposed (a bug in the cgtypes code?). ADDING it to a tuple or list is fine: `(mat4(1),)`<br/>• A tuple or list of any combination of the above that makes sense.<br/><br/>Tuples and lists are flattened out before they are written. As long as the number of atoms is equal to size x width, it’ll work. Calls to propertyData() must appear in the same order as declared with the property() method. | [Method] |
| `void gto.Writer.endData ()` | Closes the definition of data started by beginData() and finishes writing the gto file. Does *not* actually close the file–use the close() method for that. | [Method] |

## Classes used by gto.Reader

Note that as of the 3.0 release, these classes will contain the actual strings rather than string table IDs.

| | | |
|-|-|-|
| `gto.ObjectInfo` | This class emulates the Gto::ObjectInfo struct from the C++ Gto library. It is passed by the Python gto.Reader class to your derived `object()` method. The only methods implemented are `___getattr__` and `__repr__`. Available attributes are:<br/>• `name`: String<br/>• `protocolName`: String<br/>• `protocolVersion`: Integer<br/>• `numComponents`: Integer<br/>• `pad`: Integer | [Class] |
| `gto.ComponentInfo` | This class emulates the Gto::ComponentInfo struct from the C++ Gto library. It is passed by the Python gto.Reader class to your derived `component()` method. The only methods implemented are `__getattr__` and `__repr__`. Available attributes are:<br/>• `name`: String<br/>• `numProperties`: Integer<br/>• `flags`: Integer<br/>• `interpretation`: String<br/>• `pad`: Integer<br/>• `object`: Instance of gto.ObjectInfo | [Class] |
| `gto.PropertyInfo` | This class emulates the Gto::PropertyInfo struct from the C++ Gto library. It is passed by the Python gto.Reader class to your derived `property()` and `dataRead()` methods. The only methods implemented are `__getattr__` and `__repr__`. Available attributes are:<br/>• `name`: String<br/>• `size`: Integer<br/>• `type`: Integer<br/>• `width`: Integer<br/>• `interpretation`: String<br/>• `pad`: Integer<br/>• `component`: Instance of gto.ComponentInfo | [Class] |
