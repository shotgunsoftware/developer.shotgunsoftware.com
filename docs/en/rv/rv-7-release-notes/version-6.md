---
layout: default
title: Version 6 Releases
permalink: /rv/rv-7-release-notes/version-6/
lang: en
---

# Version 6 Releases

## Version 6.2.8 (RELEASE - 12 Jul 2016)

**NEW**
* Added new command line option *-sendEvent* to send external events to RV.
* Improvements to audio/video sync.
* New package that adds a menu item under the Image menu called *Collapse Image Sequence*. This package provides a way to collapse a loaded frame sequence to the frames present on disk by pruning the missing frames with an RVRetime node.

**FIXED**
* No longer use merge stack operation with Topmost mode by default.
* Correctly update the path to open from the fileOpenDialog (in either details view) when clicking in a column other than “name”.
* Fixed crash reading session files with unknown media
* Allow use of *"* and *\* characters in password strings during authentication.
* Platform Audio: Fix audio corruption playback issues with multiple RVs under centos7/rhel7.
* Platform Audio: Silence pcm_dmix console message.
* Fix incorrect pixel inspector source pixel values when reading .r3d files.
* Range submenu of the per source Color menu now works when multiple sources are in view.
* Update RV title bar when a replacing source media.
* Fix crash case with -eval.
* Fix memory leak for rv python commands that return PyDict.
* Improved sources filter in command commands.imagesAtPixel.
* Improved parsing of CC type CDL files when using RVCDL nodes.

## Version 6.2.7 (RELEASE - 16 February 2016)

**PLEASE NOTE:** RV 6.2.7 uses Python 2.7. As of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 6.2.7 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* **Network HTTP Proxy Support**
* **Two-Factor Authentication** for Shotgun integration and authentication.
* AJA Kona RV-SDI: support for the 1920x1080p 23.98fps mode.
* Support for media files with the “.mpg” extension.
* ARRI SDK: Update to SDKv5.1 release Oct2015 (fixes Alexa65 issues).
* Color menu options let you manually select Color Range options.
* OpenEXR: handle incomplete scanline, deepscanline, deeptiled EXR files similarly to incomplete tiled images.
* For TIFF images with more that 4 unlabeled channels, treat first 4 channels as RGBA.
* Support for synchronizing matte settings during RV remote sync.
* By default, the Shotgun authentication will prefer HTTPS connections; setting the *RV_SHOTGUN_AUTH_NO_HTTPS* environment variable will now ensure that HTTPS is not used unless specifically requested.

**FIXED**
* Shotgun integration: after painting on a “Compare” view and then Comparing new Versions, the previous paint could be “left over”.
* Shotgun licensing dialog: Return and Enter keys will now trigger the “Continue/OK” button.
* HDMI 1.4a “frame packed” stereo output mode was broken.
* Default settings in LibRAW caused luminance to flicker in some DNG image sequence.
* For some sequences with “gaps”, the images for the frames that did exist could be “piled up” at the beginning of the sequence.
* Recent linux NVIDA drivers could cause the device “display name” in RV to be just a number.
* RVPUSH “set” command was flipping the sign on negative per-shot parameters.
* Better support for DNxHD movies with COLR atom.
* OpenEXR bug that could cause thread deadlock when reading/writing EXR files.
* If a previously-selected output audio device becomes unavailable, fall back gracefully to the default device.
* Shotgun integration: fall back to using file pixel aspect metadata if unspecified.
* Use current stereo mode (anaglyph, side-by-side, etc) when exporting a media from RV.
* In some cases, the stereo offset setting in one input of a Stack could affect the others.
* RVSDI: Loading a new session when Presentation Mode was active could cause RVSDI to hang.
* Traversing a directory with image files that could not form a sequence sometimes caused a crash.
* Drag-and-dropped folders containing more than one frame sequence were not handled properly on Windows.
* The width of some annotation brush types did not sync during remote sync.
* When viewing a Stack, the ImageInfo HUD widget displayed info for the bottom element, instead of the top.
* The preferred presentation device was not found when the monitor name contained a “/”.

## Version 6.2.6 (RELEASE - 21 October 2015)

**PLEASE NOTE:** RV 6.2.6 uses Python 2.7. As of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 6.2.6 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* The optional Stereo Disassembly RV Package now supports full-frame *packed* stereo sources.
* Support for Truelight “cub” LUT file format.

**FIXED**
* As of RV 6.2.4, intended default activation of Screening Room RV Package was not working.
* Optional *Scrub Offset* RV Package fixed to work with RV6 Session structure.
* Optionally restore previous (as of RV4) default behavior for movies containing ICC profiles.
* Coordinates returned by *imageGeometry()* command were incorrect for the controller device when Presentation Mode was active.

## Version 6.2.5 (RELEASE - 6 October 2015)

**PLEASE NOTE:** RV 6.2.5 uses Python 2.7. As of this release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 6.2.5 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* **PyOpenGL** Version 3.1.0 distributed with RV on all platforms.
* **RV Windows Installer** Please Note: The installer will modify the registry to install an RVPUSH-based handler for *rvlink* URLs so please don’t use the installer if you’re managing those registry entries by hand and want to continue to do so.
* OCIO Source Setup package can now make use of external python modules, so that the package can be used without modification in more situations. Please see the Package documentation for details.
* OpenImageIO upgraded to v1.5.18 (especially for improved PSD file support on linux/windows).
* Option on the Annotation menu to use the same color for all brushes (saved as a Preference).
* Work-around for playback hiccups caused by system-level virtual memory management stalls (especially on linux).
* Additional movieproc options (see [user manual](../rv-manual.html)).
* Nvidia SDI: allow “no color conversion” case for YUV modes.
* *About RV* dialog shows build OS details, and 3rd-party package versions: Python, Boost, PySide, PyOpenGL, FFmpeg, Arri SDK, RED SDK.
* Shotgun integration: *Sequence* and *Element* URLs can be dropped on the RV view, if *Versions* are linked to those entities.
* RV Shotgun authentication: default server URL and login can be specified with environment variables.
* Convenience functions in Python *rv.qtutils* module provide PySide objects wrapping RV’s main UI elements; see example in the [user manual](../rv-manual.html).

**FIXED**
* RVIO: last scanline of output was black in cases where input EXR data window was larger than display window, and only the display window was read.
* In some stereo presentation modes, a cache management bug would cause the size of the cache to appear to shrink.
* Due to a Qt bug, the *Platform Audio* module did not list the *pulse* device on newer linux distributions such as CentOS 7, Ubuntu 14, and Fedora 20.
* Filtering by file type was broken in Open dialog and related API commands.
* RV will now restrict “frame number detection” to strings of digits in the filename of 9 characters or less.
* More improvements for unicode file IO.
* Re-worked some preferences code to try to prevent reported “preferences unexpectedly reset” problem on linux.
* Values for “uncrop” width/height of *RVImageSources* were not restored from session files.
* Values for “size” and “autoSize” properties of *Stack/Merge/Combine* instance nodes were not restored from session files.
* Supplied channnel names were not set on FrameBuffers created by *RVImageSources*.
* ERROR message when using “http” (instead of “https”) Shotgun URL for authentication changed to INFO message.
* The MuSymbol constructor now loads the module containing the requested symbol if it is not loaded already.
* Float *FPS* and *framesPerSecond* metadata in EXR files was not respected.
* RVSDI: with latest SDK, AJA device output was improperly limited to broadcast range.

## Version 6.2.4 (RELEASE - 4 August 2015)

**PLEASE NOTE:** RV 6.2.4 uses Python 2.7; if you require Python 2.6, please use RV 6.0.4, which is identical except for Python version.

**NEW**
* **PySide Python Modules** distributed for all platforms (OSX, Linux, Window). This is PySide version 1.2.2. An optional “PySide Example” package can be loaded via the Packages preferences tab for users looking to use PySide.
* Improved unicode/internationalization support on Windows.
* AJA SDK updated to version 12.2.1 on all platforms.
* Blackmagic SDK updated to version 10.4.1 on all platforms.
* SDI SDK versions are now reported in the Video preferences tab.
* Video/SDI SDK version and additional info (e.g. recommended driver version) displayed in Video preferences.
* Added *--simple-routing* option support for Kona devices.
* Improved rendering of annotation strokes with “sharp turns”.
* Default colorspace conversion when encoding v210 media is now REC601.

**FIXED**
* Platform Audio: Fixed frame drop warning when playback resumes on Linux.
* rv/rvio: Removed maximum limit on number of command line arguments.
* During remote sync using presentation mode, the remote pointer no longer moves in opposite vertical direction on certain presentation devices.
* Fixed layer/channel selection on multipart exrs files which have the same view for all parts.
* Fixed reading RLE encoded PSD files on Windows.
* Fixed crash when using packed fluid layout with one source.
* Fixed SDI Kona playback output modes for “12bit 3G RGB” and “8bit 3G RGB”.
* Work-around for “mixed fps” DPX files from Mistika.

## Version 6.2.3 (RELEASE - 23 June 2015)

**PLEASE NOTE:** RV 6.2.3 uses Python 2.7; if you require Python 2.6, please use RV 6.0.3, which is identical except for Python version.

**NEW**
* **SMPTE VC-3 Codec (DNxHD)** enabled for mio_ffmpeg.
* **PySide Python Modules** Distributed for linux only, these modules should be considered **alpha**, for testing purposes only.
* Support 12-bit DPX files with unpadded scanlines.
* RVLS now accepts one or more Session Files as input. In that case, it will report information about the media referenced by the Session File.
* RVLS has a *-o* command line option to specify an output file.
* Environment variable *TWK_SERVER_PORT_FALLBACK_COUNT* can be set to determine the number of ports RV will try when looking for an open port to listen on for a network connection. The default is to try 10 ports.
* RVCDL node with *node.file* property will automatically update CDL values from files of type CCC, CC, or CDL.
* ARRI Raw SDK updated to version 5.1 (4.6 on Linux because ARRI does not distribute libs compatible with our CentOS 5 target. Please let us know if you need a 5.1 build for linux/centos6.)

**FIXED**
* Increase *Timeline Magnifier* render performance when there are many marked frames.
* RV could crash after saving a *Display Profile* containing a LUT
* Exporting a movie or frame sequence when using a Display LUT could cause a crash.
* Adding additional nodes to a PipelineGroup containing a LUT could cause the LUT to have no effect.
* Screening Room: Media with timecode could confuse the sequence setup so that frame numbers did not match sequence frame numbers.
* Screening Room: Sometimes the correct (current) Version would not highlight in the Screening Room panel.
* Screening Room: The main view “step left/right” hotkeys were broken when the Screening Room browser was visible.
* *RVLensWarp* node: the “center” parameter for the OpenCV distortion model was not used correctly.
* Complicated PipelineGroup contents, especially PipelineGroups within PipelineGroups, could cause a crash.
* The *-strict* command-line flag would cause RV to exit if it could not acquire an *rvsolo* license. Now it correctly enters the *unlicensed* state in that case.
* Two AJA Kona video modes (“10 Bit YCrCb 4:2:2” and “Stereo Dual 10 Bit YCrCb 4:2:2”) could not be stored as preferences.
* A sequence of EXRs wherein all the files did not have the same set of layers could cause a crash.
* Remote sync could fail on string properties with “/” characters in their values.
* Some Python headers were missing from the distribution.
* Multi-byte unicode filenames would prevent *mov* and *avi* files from loading.
* Mattes now render **below** text and rectangle overlay objects defined in the same *RVOverlay* node.
* Geometric resize combined with bit-depth reduction of 16-bit planar images could cause a crash.
* Custom PipelineGroup contents that include both OCIO nodes and a user-defined custom node could cause a crash.
* True location of Python site-packages directory was not being added to system path.
* The disted pyconfig.h included macros specific to the internal build system.
* In sessions with many paint/annotation strokes, adding new strokes could get very slow.
* RVSDI: improved output frame rate calculation and display.

## Version 6.2.2 (RELEASE - 5 May 2015)

**PLEASE NOTE:** RV 6.2.2 uses Python 2.7; if you require Python 2.6, please use RV 6.0.2, which is identical except for Python version.

**FIXED**
* Use of OpenColorIO could cause a crash (all platforms).

## Version 6.2.1 (RELEASE - 29 April 2015)

**PLEASE NOTE:** RV 6.2.1 uses Python 2.7; if you require Python 2.6, please use RV 6.0.1, which is identical except for Python version.

**NEW**
* **Licensing RV Via Shotgun** Use your Shotgun username and password to get full RV functionality. Some answers to expected questions:
  * The current licensing style is always configurable via the *License Manager* item on the *File* menu.
  * The RV (and RV-SDI) version 6.0 executables support both licensing systems (standard Tweak licensing and licensing via Shotgun).
  * RV-SDI can be licensed via Shotgun only at sites using “Super Awesome” support.
  * There’s no requirement that a given site use only one style of licensing.
  * RV licensed via Shotgun is functionally identical to RV licensed the usual way.
  * A user can switch from Tweak-standard to via-Shotgun licensing and back (the choice is stored as a preference).
  * At a facility where standard Tweak RV licensing is set up and working, there will be no change when the user runs RV6 (they will be able to try out via-Shotgun licensing by selecting a menu item if they wish).
  * Licensing RV via Shotgun does not produce any requirement to use Shotgun for other purposes. For example, users may license RV via Shotgun, but not use Screening Room.
  * A user who authenticates RV via Shotgun username/password once, and then runs RV at least once a week, will not have to authenticate again. (The original authentication will be refreshed on each run, assuming that the Shotgun server is accessible, and the username/password is still valid).
  * Similarly, an RV user who authenticates via Shotgun will be able to use RV “offline” (when the Shotgun server is unavailable) for 30 days, starting from the most recent “online” use.

Intro video and additional Shotgun setup details available [here](https://support.shotgunsoftware.com/entries/92074518), and complete RV licensing details [here](..//rv-client-license-management.html).

* **Media Export with no RVIO License** Using RVIO to export media from RV will be allowed as long as RV is licensed (with any licensing scheme). Usage of RVIO “on the farm” (or otherwise unassociated with any local RV process) will still require a standard Tweak license.
* **RVX Functionality in RV** The functionality previously available only in the RVX executable will now be available in RV (we will no longer distribute RVX). This includes the use of unsigned custom GLSL shader nodes.
* Experimental *Stereo Disassembly* RVPackage to support “disassembly” of top-and-bottom or side-by-side “squeezed” stereo media. (Details in Packages preferences.)
* Experimental *LatLong Viewer* RVPackage allows the addition of a LatLong Viewer node for viewing un-warped lat-long (spherically-mapped) media. Shader courtesy The Mill! (Details in Packages preferences.)
* Per-frame meta-data display from RED R3D movie files.
* RVSDI: additional supported Kona4/IO4K video modes (UHD 60Hz, etc).
* RED R3D SDK updated to version 5.3b2 (Jan 2015).
* The *Color Channel Select* package can display luminance via the *l* hotkey.
* An option on the *File/Export* menu to export an “RVIO-Ready” Session file, with the current display copied into the “Output” transform that RVIO will use.
* Improved support for multi-byte encodings in filenames, etc.
* Quicktime *Timecode/ReelName* metadata can now be read and written.
* ARRI Raw SDK updated to version 5.0 (4.6 on Linux because ARRI does not distribute libs compatible with our CentOS 5 target. Please let us know if you need a 5.0 build for linux.)
* *IOARI_ARGS* environment variable can set the ARRI Raw decode color space with *--colorspace*
* Quicktime reader supports movies with ICC profile in *COLR* atom.
* *RVOverlay* node supports softer stereo window drawing.
* RVIO supports ARRI LogC target with *-outlogc* command-line flag (you can specify LogC EI parameter with *-outlogcEI*).
* FFMpeg updated to version 2.6.1.
* Limited MXF containers support.
* Additional movieproc type “syncflash” for testing audio/video sync.
* Custom LUT Package: Added autoload support to source LUT/CDL slots.
* Sources Details: display files-space CDL settings.

**FIXED**
* When viewing a user-defined merge node, zooming the view would appear to affect only one of the merge inputs.
* If the underlying Audo system supplies a device called “default” selecting it in RV’s preference would not “stick”.
* A Layout view in tiled (“packed”) mode containing media with different aspect ratios sometimes did not “frame” correctly.
* Several problems associated with audio range and offset; in particular a global offset could conflict with a source-level offset causing missing audio.
* OpenEXR: DWA compression bug ([https://github.com/openexr/openexr/issues/156](https://github.com/openexr/openexr/issues/156)).
* On the Python *Event* class, the methods *relativePointer* and *timeStamp* did not work.
* Some quicktimes written by Nuke would not show the first frame when displayed in RV.
* For quicktime timecode calculations, use frame rate from timecode track, rather than video track.
* Combining a multi-frame leader with an image overlay could cause RVIO to crash.
* Opening the preferences dialog could cause the OpenEXR decoder thread count to be reset to 1.
* Occasional crashes when reading Session Files containing complicated PipelineGroups.
* Insufficient precision in ASCII session files could cause drift in FPS values.
* In some cases an RV3-version session file containing annotation paint strokes was not loaded into RV4 correctly.
* The Annotation mode was consuming some events (like “frame-changed”), and interfering with other modes (like Screening Room).
* Creation of new Display Profiles was broken.
* Session Manager “New Node by Type” drop-down automatically populated.
* Crash when clearing session during rendering.
