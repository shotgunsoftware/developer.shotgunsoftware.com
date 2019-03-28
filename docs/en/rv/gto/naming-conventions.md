---
layout: default
title: GTO: Naming Conventions
permalink: /rv/gto/naming-conventions/
lang: en
---

# Naming Conventions

GTO files can contain cross references to parts of themselves, objects outside the file, or virtual/logical objects in applications. Because of the potential morass that can result from complete free-form naming, there are conventions which are part of the file specification.

Failure to follow the guidelines does not mean a GTO file is ill-formed; there’s always a good reason to ignore guidelines. But having a basis for consistency is usually a good idea.

Some of these topics are a bit “advanced” in that they build off ideas that present themselves after using the file format for a while. If you are just learning about the format, consider this a reference section and skip it. If you’re trying to decrypt a complicated GTO file with strange garbled naming, then this section is for you.

## Valid Names

Names should be valid C identifiers, but should not contain the dollar-sign character ($). This means that no whitespace or punctuation is allowed.

Note that this does *not* apply to protocol names.

There is nothing in the sample `Reader` or `Writer` classes which enforces the valid name guideline. However, some applications (Maya) cannot handle names with whitespace and/or punctuation. So plug-ins which implement GTO reading/writing will have to enforce the application’s specific naming requirements.

This guideline is broken by Section Special Cookies. It is also broken by Section Cross References.

## Exactly Specifying a Property or Component

By convention, the full name or path name of a property is referred to like this:

```
OBJECTNAME.[COMPONENTNAME.]+PROPERTYNAME
```

where there can be any number of COMPONENTNAME parts. When indicating a property name relative to an object then:

```
[COMPONENTNAME.]PROPERTYNAME
```

should suffice. In this manual, names of components and properties are disambiguated using the dot notation. In addition, this is the format of output from the gtoinfo command. There is nothing about the GTO file itself which relates to this notation other than the cross-referencing naming convention discussed below.

## Indicating Special Handling

Some objects, components, or properties in the GTO file may contain data for which names are not particularly useful or that may simply pollute the object or component namespace.

In other cases (component names most notably) the name may be used as information necessary to interpret data associated with it.

In order to distinguish these names from run-of-the-mill names, you should include a colon in the name. Names with colons are considered “special cookie” names and objects which have them may be handled differently than other objects.

The **connection** object protocol, for example, requires that a special file object exist to hold data. This object is not necessarily related to a logical object in the application, it is just a container for the connection data. These objects are named using the special cookie syntax. Usually the name is “:connections”. See Section Inter-Object.

There is no rule regarding the placement of the colon in the name; it can appear anywhere in the name that is useful for the application. However, if the entire name is a special cookie—there is not additional information encoded in the name beyond itself—the recommend form is to have the colon be the first character.

## Cross References Encoded in Names

Sometimes there is a need to have a property or component *refer* to another property, component, or object in the file (or somewhere else).

To cross reference the data in one property with another, simply name the property the full (or partial) path to the referenced property. For example, here’s the output of `gtoinfo` on a GTO file which has cross referencing properties:

```
object "gravity" protocol "gravity" v1
     component "field"
          property float[3][1] "direction"
          property float[1][1] "magnitude"
     component ":datastream"
          property float[3][300] "field.direction"
          property float[1][300] "field.magnitude"
```

As you can guess, the intention here is that the properties called “field.direction” and “field.magnitude” in the “:datastream” component are data that is associated with the properties “direction” and “magnitude” in the “field” component.
