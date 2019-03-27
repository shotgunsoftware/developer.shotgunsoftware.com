---
layout: default
title: GTO: Issues and Questionable Aspects of the Format
permalink: /rv/gto/09-issues-and-questionable-aspects-of-the-format/
lang: en
---

# Issues and Questionable Aspects of the Format

* There are currently no (publicly available) tools which verify that a file claiming to follow some protocol is correct.
* There is no 3D curve(s) protocol defined.
* The **NURBS** protocol does not handle trim curves. See Section NURBS Surfaces.
* The format does not contain dedicated space for auxillary information like the name and version of the program that wrote the file, the original owner, copyright information, etc. However, our tools use the string table for these type of data—since its not an error have an unused interned string, we store the data as such. In our opinion, this is a fairly innocuous method. You can read unreferenced strings by using the `gtoinfo` command with the `-s` option. Note that these strings are often lost when programs read and write the file. See Section gtoinfo.
* Although the format specification includes transposable components (those marked with the Gto::Matrix flag may be transposed), the current reader/writer library does not handle files with transposed components. It does handle components that are marked as Gto::Matrix but not transposed. See Section Particles.
* The use of special cookie names and special cross-reference names seems to seriously complicate the format if the protocol is not carefully conceived. For example, using `gtomerge` to merge files containing connections does not work—the connections are merged like all the other data in the file. The correct behavior would be to combine the connections, but merge the other object data. Perhaps this is just a case for integrating `gtocombine` into `gtomerge`?
* Future versions should incorporate some form of check sum or some similar mechanism to do better sanity checking.
* There are many examples of properties whose data indexes into other property data. The most obvious of these are the polygon protocol **indices** properties. In order to combine gto files (concatenate polygonal data together for example) its necessary to know which properties are indexes and which are not. Index properties must be offset to be combined.
* The Boolean (bit fields) and Half data types are not implemented in the supplied writer library. Both of these types are useful in compressing geometric (and image) data.
* Material, Texture, and similar assignments and storage are usually very specialized at any particular production facility. The idea that a single method of encoding this information can be determined or enforced—or even usefully be stored in a GTO file—is not realistic. However, we hope that some method can be determined that at least preserves a good portion of common data for transfer.

All of the protocols related to these concepts are marked **PROPOSED** in this document. See Section Material.
