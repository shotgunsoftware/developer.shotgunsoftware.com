---
layout: default
title: GTO: Appendix A
permalink: /rv/gto/14-appendix-a/
lang: en
---

# Appendix A: Description of Changes

* Version 4.0
  * Property data size can now be larger than 4Gb in the file and readable in full on 64 bit architectures (if the library is compiled 64 bit). The file headers are now version 4. The new file is incompatible with version 3 GTO readers.
  * The manual has been updated with real-world usage examples from the film and game industries.
* Version 3.4
  * The GTO license terms have been changed: the code is still covered by the LGPL, but with additional exceptions similar to those used by the FLTK library. These exceptions make it easier to use GTO in commercial projects.
  * Houdini I/O plugin (ggto) reads and writes GTO geometry.
  * The library no longer attempts to be source code compatible with older Microsoft compilers. Some functions may throw on error.
  * Maya plugin (loadGtoAnim) loads animation from GTO files (transform matrices only). Useful for getting animation from GTO difference files.
  * Maya plugin (GtoDeformer) makes it possible to use GTO files as geometry cache files. The deformer will read vertex/cv positions from existing GTO files and applies them to scene geometry of the same name.
  * Maya plugin (GtoParticleDisplay) loads particles from GTO files for viewing in Maya
  * Maya plugin (GtoParticleExport) writes particles from Maya as GTO files. Can be used as a replacement for pdb and pdc files.
  * Maya plugin (GtoCacheEmitter) loads particles into Maya from GTO files via an emitter.
  * Bug fixes to the C++ Gto::Writer class for output of text GTO files.
  * Run-time error checking of the Gto::Writer API. The class will complain if the API is used in a undocumented manner. It may throw an exception.
  * The GTO source code distribution now comes with Maya and Houdini plugins for cached deforming geometry and particle export and display.
* Version 3.2
  * Human readable plain text version of GTO. Some readers may not function if they assume that the property size is known when the property() virtual function is called. The property size is only really known when the data() virtual function is called. Only version 3.2 GTO readers can read the text version.
  * Animation curves are now stored per-object using the animation protocol.
  * Bug fixes to Gto::Reader class to allow reuse of existing class with a newly opened file.
* Version 3.1
  * RenderMan plug-in documentation added.
* Version 3.0
  * An interpretation string has been added to the property header.
  * An additional uint32 has been added as padding to the object, component, and property headers for future expansion slop.
  * A section on interpretation strings has been added to the documentation and to the reader/writer classes.
  * Added a type reference to the documentation.
* Version 2.1
  * gtofilter was changed to optionally accept POSIX style regular expressions in addition to shell-like “glob” expressions.
  * The C++ writer class now defaults to writing compressed files when the open() function is called. A second bool argument can be passed to it to prevent the compression.
  * The proposed texture assignment protocol (from version 2.0.4) has been rejected.
  * A new protocol “channel” is introduced for assigning mapped surface varying data on geometry. An arbitrary number of texture maps may be assigned to the geometry. See Section Channels.
  * The material protocol has been fleshed out. See Section Material.
  * The polygon protocol was missing the definition of the optional mappings component. See Section Polygonal Surfaces.
* Version 2.0.5 Bug fix version. Repaired problems with the
configuration scripts. Missing headers.
* Version 2.0.4 Bug fix version. Some configuration problems solved.
* Version 2.0 File headers changed. The format is not compatible with 1.0.
* Version 1.0
