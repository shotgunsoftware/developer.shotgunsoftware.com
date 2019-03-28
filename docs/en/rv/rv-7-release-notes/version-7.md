---
layout: default
title: Version 7 Releases
permalink: /rv/rv-7-release-notes/version-7/
lang: en
---

# Version 7 Releases

## Version 7.3.0 (RELEASE - December 4th, 2018)

**NEW**

* Support for TLS 1.2
* Support for AJA SDK 14.2.0.6. This enables support for IO 4k Plus. (see Note Above)
* Support for MP3 and Vorbis audio decoders
* Rendering - Use Open GL Pixel Buffer Objects preference is now enabled by default
* Screening Room for RV is now the default Shotgun integration package.

**FIXED**

* Resolved Import Cut error trying to write read only "image_source_entity" field with Shotgun 7.12+ site
* Resolved GL Corruption when Look LUT and GLSL node are combined
* Resolved bad GLSL evaluation when LUT and Annotation enabled
* Resolved rendering issue using OCIO file transform with a stack layout in replace mode
* Resolved issue when sometimes audio would be reported shorter then it is  
* Improved inaccurate playback frame rate reporting

## Version 7.2.6 (RELEASE - October 9th, 2018)

**FIXED**
* Resolved audio stuttering issue caused by console event logging inefficiency
* Resolved issue viewing source image with non-square pixel aspect ratio
* Resolved stereo issue that prevents viewing both eyes side-by-side with MultiChannel EXR
* Resolved Pixel Inspector precision issue when viewing source with flipped coordinates
* Resolved corruption issue loading some palette based PNG
* Resolved playback performance issue with some MultiPart EXR files
* Resolved misleading console error output with AJA SDI auto-circulate

## Version 7.2.5 (RELEASE - August 7th, 2018)

**FIXED**
* Resolved an issue with AJA stereo modes that would make eyes lose synchronization.
* Resolved an issue in Screening Room that made it feel disconnected from RV when update frequency was set to Never when your clicks were fast.
* Resolved Overlay performance issue with multiple font sizes
* Resolved a playback performance issue that slowed down your EXRs when you have a slate with a different view than the rest of the source
* RVSDI: Added missing 1080@25Hz timing for AJA adapters

## Version 7.2.4 (RELEASE - June 26th, 2018)

**FIXED**
* Resolved Session Manager swapping views when image component is selected outside Session Manager
* Resolved crash when selecting a layer which doesn’t exist in the first frame
* Resolved an issue preventing non-square pixel aspect ratio sources from being forced into displaying as square pixels

## Version 7.2.3 (RELEASE - April 25th, 2018)

**FIXED**
* Resolved Screening Room NGINX errors out when attempting to load Screening Room from RV

## Version 7.2.2 (RELEASE - April 9th, 2018)

**PLEASE NOTE:** RV 7.2.2 uses Python 2.7. As of 7.2.0 support for Nvidia SDI has been removed and we no longer support python2.6, centos5, OSX 10.7 and 10.8 as part of the standard distribution.

**NEW**
* RVSDI BlackMagic Declink: Added 4K UHD HFR formats choices i.e. 50,59.94 and 60fps.
* Changed movieproc *syncflash* behavior so that the first sync flash frame does not occur on the start frame.
* Add support for NTLM SSO authentication

**FIXED**
* Resolved issue of slow playback speed for padded 12bit DPX files on certain nvidia cards e.g. K6000.
* Resolved incorrect overlay frame number on annotation from SR for RV.
* Replace use of *numpy* in EXR data window display package; resolves possible *package not found* error.
Resolved console warning message about an AJA device “null string”.
* Preserve source group names when reading session files.
* Silence unsupported timecode frame rate console errors messages.
* Resolved crash associated with the reading of indexed PNG files.
* Resolved cropped quads issue for AJA SDI when AJA control panel default display mode differs from RV AJA SDI preference display mode.
* Resolved missing file open command with network sync.
* Resolved issue with the source-setup plugins.
* Resolved presentation mode wipe wrong handles issue.
* Resolved Next/Prev marked frame or range skipping items
* Resolved uncrop rvio export issue
* Resolved issue with slate image having different format than the rest of the EXR sequence.
* Resolve issue with embedded ICC profile clamping colors

## Version 7.2.1 (RELEASE - 19 Sept 2017)

**PLEASE NOTE:** RV 7.2.1 uses Python 2.7. As of 7.2.0 support for Nvidia SDI has been removed and we no longer support python2.6, centos5, OSX 10.7 and 10.8 as part of the standard distribution.

**NEW**
* ARRI SDK: Updated to SDK v5.3.0.15 Feb 2017 (bug fix) release.
* Added ChapterInfo to SourceMediaInfo. This allows per source chapter metadata for navigation from Mu and Python.
* RVSDI AJA preferences: Added new optional flag `"-a"`(`"--level-a"`) that will enable Level A timing for formats that allow it.
* Added the ability for custom packages to initialize the SG Review toolkit engine with `external-sgtk-initialize` or from the RV command line with `"-sendEvent sgtk-initialize"`.

**FIXED**

* Resolves deadlock/hanging with stereo autoload enabled. (This was a regression in 7.2.0)
* Ensure python is built with ucs4 encoding on linux. (This was a regression in 7.2.0)
* Addressed mu related memory leak with the *image info* tool enabled.
* Addressed memory leak when Rendering preference “Use OpenGL Pixel Buffer Objects” is enabled. (This was a regression between version 6.2.x/7.0.x and 7.1.x/7.2.0)
* Resolve issue where custom node LinearToAlexaLogC was clamping legal negative pixel values.
* Resolve RVSDI failing to launch on Windows machines without vs2010 redistributables dll libs installed.
* We now respect `"-outparam vcc:color_range"` in writing for both metadata and color conversion where codec allows.
* Properly restrict Color → Range menu to sources in view.
* Resolved audio playback issue in “merge” glsl nodes (as used by stereo disassembly)
* Resolved crash creating RVImageSources.
* Resolved crash loading certain session files with large often layered media.
* Revert “Default Screening Room UI refresh to the *Never* option”. (This was a regression in 7.2.0)
* Resolved Screening Room issue where annotation from previous Compare view was not cleared.
* Resolved SG Review issues with URLS that were upper-case, or contained a trailing slash.
* Ensured SG Review now respects Version’s per-media-type pixel aspect ratio field.
* SG Review now falls back to full media frame range rather than 1-100 when Version has empty first/last frame fields.
* Resolved issue where SG Review loaded media for the entire cut when only the mini-cut was viewed.
* Resolved RVSDI HDMI out issue with AJA T-tap devices.
* Resolved RVSDI AJA issue related to loss of audio when toggling presentation on and off.
* Resolved RVSDI BlackMagic frame sync offset between left/right eyes for stereo formats.
* Resolved a crash that resulted from wiping Views instead of Sources. (This was a regression in 7.2.0)

## Version 7.2.0 (RELEASE - 31 May 2017)

**PLEASE NOTE:** RV 7.2.0 uses Python 2.7. As of 7.2.0 support for Nvidia SDI has been removed and we no longer support python2.6, centos5, OSX 10.7 and 10.8 as part of the standard distribution.

**NEW**
* **SDI functionality for all RV users:** Features that were previously reserved for RV-SDI licenses are now enabled for all users. RVSOLO licenses will now enable the use of these features.
* **Streaming playback in Shotgun:** You can now stream video from Shotgun without the need to have the media locally on your machine. Includes updates to Shotgun Review to support streaming too.
* **Single-Sign On (SSO) for Shotgun RV:** Users authenticating their RV license through Shotgun can now do it through SSO. Note this feature is only available to clients with “Super Awesome Support”.
* **RVSDI AJA SDK updated to v12.5** The AJA SDK has been updated to v12.5.1 on OSX and Windows; and v12.5.2.7 on Linux.
* **ICC Display profile support:** This is supported on OSX and Windows. You can elect to enable ICC nodes by setting RV_IGNORE_ICC_PROFILE to 0\. Please note enabling this option may cause your session files to generate error messages when read back in older RV versions.
* Added a new rv python command called *releaseAllUnusedImages* that frees memory allocated to unused images.
* Updated all RV builds to use Qt 4.8.7 (from Qt 4.8.5)
* Updated RV Linux and Windows builds to use Python v2.7.11 (from Python 2.7.3).
* Updated RV Windows build to use VS2013 (VC12) compiler. (from VS2010)
* Updated RV’s “About” window to display more detailed software build and dependent package information.
* Added the audio preference “Fast Loopback+PreRoll Audio” for OSX and Windows too.
* Default audio preferences for linux have been changed to reflect settings ideal for playback performance.

**FIXED**
* Resolved cases where audio buffering occurred unnecessarily.
* Resolved mispositioning of image with EXR format choice Data-In-Display Window for certain data and display window configurations. This was a regression from RV version 6.x.x/7.0.x.
* Resolved issue with using RV wipes, annotation, pixel inspector tools with EXR images where the data window did not equal the display window.
* Resolved issue with using EXR data/display window drawing package with EXR images where the data window did not equal the display window.
* Under OSX, fixed the issue where entering fullscreen mode causes drag-and-drop to stop working.
* Added support for nclx color parameter type in COLR atom.
* Resolved AJA SDI playback issue with HFR (>30Hz) formats on Windows.
* Resolved a memory leak associated with python to mu event conversion.
* For RV annotation, ensure the eraser erases for all cases.

## Version 7.1.2 (RELEASE - 15 Mar 2017)

**PLEASE NOTE:** RV 7.1.2 uses Python 2.7. As of 7.1.2 we no longer support OSX 10.7 and 10.8 as part of the standard distribution. Also, as of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 7.1.2 Linux build is targeted at CentOS6. If you really need Python 2.6, CentOS5, OSX 10.7 or OSX 10.8 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* Added new audio preference “Device Latency” to allow for the correction of measured playback AV sync delays.
* Added new audio preference “PreRoll Audio on Device Open” that improves the consistency of AV playback on various linux machines and audio devices. NB: This preference is only available for Platform Audio on Linux.
* Added support for TTF font and origin placement. This allows for simpler positioning of text annotations and overlays.
* RV mode/package load times are now displayed.
* RED/R3D SDK: Updated to SDK v6.2.2 Oct 2016 release.

**FIXED**
* Do not show CDL values unless the CDL is active.
* Improved handling of seek failures for certain movie formats like avi.
* Improved RVIO default codec selection (for writing).
* Fix potential instability when writing png files.
* Addressed a potential cause of thread instability under Windows10.
* Resolved mispositioning of image with EXR format choice Data-In-Display Window. This was a regression from RV version 6.x.x/7.0.x.
* Resolved crash loading session files with %v/%V in paths. This was a regression from RV version 6.2.6.
* Ensure caching of correct frame in non-interframe movies.

## Version 7.1.1 (RELEASE - 6 Dec 2016)

**PLEASE NOTE:** RV 7.1.1 uses Python 2.7. As of 7.1.1 we no longer support OSX 10.7 and 10.8 as part of the standard distribution. Also, as of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 7.1.1 Linux build is targeted at CentOS6\. If you really need Python 2.6, CentOS5, OSX 10.7 or OSX 10.8 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* ARRI SDK: Updated to SDK v5.3 Oct 2016 release. This resolves an error opening certain arri files.
* Updated RV/RVSDI for OSX to Qt v4.8.7 (patched) to support OSX 10.12 (Sierra).
* RVSDI: Stereo formats for BlackMagic DecLink/UltraStudio devices are now supported.
* Enabled OpenSSL in FFMpeg for https streaming support.

**FIXED**
* Restore support that allows URLs to be opened like streaming movie links. This was a regression between 7.0.1 and 7.1.0.
* Address audio artifact issues in some of the codecs like AAC under rare conditions.
* Allow view/layer selection when Preferences→Formats→OpenEXR→“Read as RGBA” option is selected.
* Handle the case where a DPX header has a zero or corrupt pixel aspect ratio by defaulting to one.
* Generalize the handling of 1-channel per track multi-channel audio to other formats besides ProRes e.g. MXF.
* Added checks in mio_ffmpeg movie reader to protect against crashes triggered by mismatched frame resolutions within single movie file.
* Handle `RV_PATHSWAP_<VAR>` values with or without trailing slash.
* Scrubbed rv docs for spelling errors and typos.
* Resolved channel mapping regression between 7.0.1 and 7.1.0.

## Version 7.1.0 (RELEASE - 4 Oct 2016)

**PLEASE NOTE:** RV 7.1.0 uses Python 2.7. As of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 7.1.0 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* **MultiChannel Audio support**. Details [here](../rv-manual/user-interface.html).
* RVSDI AJA Kona/Blackmagic Declink: Added audio options for 5.1 (AJA only), 7.1, 7.1 (SDDS) and 16 channel.
* RVSDI Blackmagic Declink SDK updated to v10.7.
* Added stereo display option *Luminance Anaglyph* for non-color anaglyphs.
* FFMpeg updated to v2.8.7.
* Boost libs updated to v1.56.
* LibRAW updated to v0.18.0. (supports Canon 5DS/R, 80D and 1DXMKII raw images).
* ARRI SDK: Updated to SDK v5.3 March 2016 release.
* Red R3DSDK: Updated to SDK v6.2.1 Aug 2016 release. Added support for Red chromaticities and RedLogFilm. Changed default decode pixel type to *PixelType_HalfFloat_RGB_ACES_Int*.
* New exr format preference *Read Window is Display Window*. This option treats the read window as the display window size instead of using the exr display attr window values.
* Added *-flag debug_export* to preserve temp files on export to help users troubleshoot export issues.
* Improve HUD information output for audio only sources.
* Added per-source command line args for file CDL *-fcdl* and look CDL *-lcdl*
* Support drag and drop of CDL files.
* OCIO package: Added independent OCIO controls for displays.
* Added the ACES Color Chart version to movieproc (*acescolorchart*).
* Added command line option *-loopMode* for specifying playback loop mode.
* Allow Platform Audio buffer/period time values to be user definable for performance tuning or to address audio buffer underuns issues with certain desktop audio devices (Linux only). Details [here](../rv-manual/k-tuning-platform-audio-for-linux.html)

**FIXED**
* Updated rv commands *eventToImageSpace* and *imageToEventSpace* so that image space orientation follows RV’s internal IP image orientation of bottom-left always and is decoupled from the orientation of the source image format. Please note this will result in a change in behavior of these calls for certain image formats whose orientation is not normally stored in the bottom-left orientation e.g., exr which is typically top-left.
* Movieproc sources newly created from the session manager are correctly named and no longer cause other views to be renamed.
* RVSDI AJA Kona: Remove unsupported “8 bit internal” choices.
* RVSDI AJA Kona/Blackmagic DecLink: Remove unsupported 1556p choices.
* Added the appropriate colorspace attributes to “SRGB Color Chart” and “Color Bars”.
* Match annotation brush widths for all brushes during sync annotations.
* Allow RVLS to clump list files with unknown extensions.
* Preserve stereo settings for export from RV.
* Handle case where scattered frames are “piled up” at beginning of sequence.
* Removed unintentional lag in AAC encoded audio tracks.
* Resolved incompatiblity with writing “faststart” libx264 files.
* Changed default color of *syncflash.movieproc* to white.
* Lat Long node properties are now synced.
* Added support for timecode EXR meta data.
* Allow session_manager and annotate windows to pass unused events to main session window.
* Handle reading of video media with poorly reported movie pixel aspect ratios.
* Resolved opacity control for annotate erase brushes.
* Empty sequences now properly play when dragging in new inputs from the session manager.
* RVDisplayIPNode property *adoptedNeural* can now be turned on/off and defaults to 1 i.e on.
* Improved compatibility with tablet/stylus inputs.
* Resolved a crash that occurs when rvpush commands are repeatedly executed over a period of time.
* Resolved a crash on Windows when opening the preference window while video is caching.

## Version 7.0.1 (RELEASE - 13 Sept 2016)

**PLEASE NOTE:** RV 7.0.1 uses Python 2.7. As of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 7.0.1 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* SG Review: Added field editing support to the Right Notes & Related Versions Pane, so you can make changes to Version info from within RV.
* Import Cut app: EDLs without a *&#42;* character on their event notes are now supported to help handle files exported from editorial applications that do not follow this convention.

**FIXED**
* SG Review fixes:
    * Cross-platform path resolution via RV_OS_PATH mapping not respecting certain links from the Media App. Details [here](https://support.shotgunsoftware.com/hc/en-us/articles/219042298).
    * Removed reporting of certain INFO messages generated by Toolkit as a Plugin that cluttered up the RV console.
    * XML errors when loading certain annotations in Screening Room for RV.
    * When using rvlink with % followed by 2 numbers, the link is misinterpreted when encoded and decoded.
* Import Cut app fixes:
    * EDLs with extraneous SUB and NUL characters at the end of the file were causing errors. These characters are now ignored.
    * We improved the copy that is displayed when a user drags in an EDL with timecode at a different frame rate than what is configured in the app’s settings to try and make it clearer that it can be adjusted easily.
    * The “Search [Entity]” text on the search bar was misaligned. It looks better now.
* Update Windows installer to create RVSDI desktop shortcut.
* RVSDI audio now supports scrubbing.
* Resolved an error reading Arri anamorphic images.
* Allow rv to encodeURL/bakeURL command lines with frame padding % syntax e.g. foo.%04d.exr.
* Some links from Screening Room panel to annotation images would fail to load into web browser.
* The annotation panel now remembers its docking location.
* Prevent license error in the *Export Cuts* package while exporting.
* Correct regression in video playback performance at 24fps on 48Hz vsync displays.

## Version 7.0.0 (RELEASE - 31 Jul 2016)

**PLEASE NOTE:** RV 7.0.0 uses Python 2.7. As of the 6.2.5 release, we no longer support Python 2.6 as part of the standard distribution. Similarly the 7.0.0 Linux build is targeted at CentOS6. If you really need Python 2.6 or CentOS5 support, please contact us directly at [support@shotgunsoftware.com](mailto:support@shotgunsoftware.com).

**NEW**
* RV 7 comes with support for Shotgun’s **SG Review** toolset introduced in Shotgun 7 (details [here](https://support.shotgunsoftware.com/hc/en-us/articles/222840748)). In addition to supporting the versioning of editorial data and the playback of media in editorial context, this toolset replaces previous RV/Shotgun integration work and has these advantages:
    * All GUI code is distributed in source with RV (instead of being served remotely) for easy modification.
    * It’s written in Python, not Mu.
    * We’re using Shotgun Toolkit standards and code so that future versions will support user-written Toolkit “Apps”.
    * A given RV Session can mix nodes and sources managed by Shotgun with others that are not without confusing the integration.
* Similar to `RV_PATHSWAP` environment variables, `RV_OS_PATH` environment variables can simplify the management of media paths on multiple platforms. See [this page](https://support.shotgunsoftware.com/hc/en-us/articles/219042298) for details.
* Added support for xdg as an rvlink protocol handler on linux (for Chrome).

**FIXED**
* On Blackmagic DecLink cards, presentation mode could crash when displaying 10bit YUV.
* A Qt bug could cause the RV preferences to be corrupted or reset during heavy use when the prefs are stored on a network filesystem.
* In “Play All Frames” mode (-playMode=1), audio/video sync errors could become excessively large.
