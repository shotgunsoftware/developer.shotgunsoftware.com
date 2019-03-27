---
layout: default
title: File Formats
permalink: /rv/rv-manual/14-file-formats/
lang: en
---

# File Formats

Each platform has a different set of file formats which RV can read by default. In addition, it’s possible to download or purchase additional file format plug-ins which allow RV to read even more. This chapter is an overview of the most important formats and how RV uses them.

You can have RV dump out all of the formats and codecs which it understands on the command like by giving it the -formats option.

```
shell> rv -formats
```

If you don’t see a codec or container format in the list, then RV doesn’t support it without installing one or more plug-ins.

## Movie File Formats

Movie files are single files which contain many images and often audio. These are often called *container file formats* because they usually specify how to store data, but not how it should be used. In most cases, that includes compression methods, play back algorithms, or even what the meaning of the data in the container is.

Container file formats have additional sub-formats called *codecs* which determine things like compression and methods of play back. So even though a program like RV might be able to open a container file and look inside it, it might not understand one or more of the codecs which are being used in the container. In some cases the codec might be proprietary or meant to be used with a specific piece of software or hardware.

### Stereo Movie Files

Most movie file formats can have multiple tracks. When RV reads a movie file with two or more tracks it uses the first two tracks as the left and right eye when in stereo mode. You can create these files using the Apple QuickTime Player or RVIO on OS X and Windows or RVIO on Linux.

### Text Tracks

On Linux, RV will read the text track of a movie file if it exists and put the contents in an image attribute per frame. You can see this with the image info widget. Text tracks can be used to store metadata about the movie contents in a cross platform manner.

### QuickTime Movie Files (.mov)

QuickTime is a wretched hoary beast. RV attempts to support QuickTime via two completely separate mechanisms: By default RV will use a plugin which leverages ffmpeg directly to handle as many formats and codecs as possible. Alternatively RV can use a plugin based on libquicktime. The libquicktime based plugin is outdated and only works on OS X and Linux.

There are literally hundreds of codecs which can appear in a QuickTime file, but only some of them are useful in post-production. RV tries to support the most popular and useful ones.

#### Photo-JPEG

This codec has qualities which make it popular in film post production. Each frame is stored separately in the QuickTime file so moving to a random frame is fast. JPEG offers a number of ways to compress the image data including sub-sampling of color versus luminance and using sophisticated compression techniques. Color representation can be excellent when using Photo-JPEG. File sizes are moderate.

Our ffmpeg plugin does not respect all of the QuickTime atom objects. Usually this is a good thing as Apple’s own library produces inconsistent results from platform to platform when displaying movie files with gama and colr atoms. The most notorious of the color atoms which typically affects the color of Photo-JPEG movies is the gama atom. The gama atom causes Apple’s Quicktime to apply two gamma corrections to the image before it is displayed. RV will not do that and RVIO does not include the gama atom when writing Quicktime movies.

With our libquicktime plugin, Photo-JPEG is well supported and encoding and decoding make no changes to the color of pixels—even in the presence of the gama atom. Files encoded with libquicktime do not include the gama atom and play back will be as expected.

#### Motion-JPEG

Motion JPEG is similar to Photo-JPEG in that they both use the same compression algorithm. The main difference is that Motion-JPEG essentially stores a single frame in two parts: all of the even scanlines as a single JPEG image and all of the odd scanlines as a separate image. The codec interlaces the two parts together to form the final image.

Motion-JPEG is supported on all platforms.

#### H.264 (avc1)

This is the latest and greatest codec which is usually associated with MPEG-4\. H.264 stores keyframes and data which helps it generate in-between frames on the fly. Because it doesn’t store every frame individually, H.264 compressed files can be much smaller than codecs like Photo-JPEG. The image quality for H.264 can be good depending on how the movie was created. If relatively simple creation software was used (like Apple’s QuickTime player or RVIO) the results are usually OK, but not nearly as good as Photo or Motion-JPEG.

#### RAW Codecs

There are a number of *raw* codecs for QuickTime. Some of these store the pixel data as RGB, others as YUV. The Raw codecs tend to be very fast to read and play back. RV supports a number of raw codecs on all platforms.

#### Audio

RV supports all of the raw uncompressed audio codecs across platforms. We are also licensed to read and write AAC audio.

RV and RVIO handle stereo audio. RV does not currently handle more than two channels of audio.

### MPEG-4 Movie Files (.mp4)

The MPEG-4 container file (.mp4) is almost identical to the QuickTime container file (.mov). The same codecs may be used to store data in either format. However, typically you find files encoded with H.264 or one of its predecessors.

RV supports the MPEG-4 container on all platforms.

### Windows AVI Files (.avi)

RV supports AVI files with the same codecs as QuickTime on all platforms.

### Windows Media Files (.wmv)

There is no official support for this file format.

### RV’s movieproc Format (.movieproc)

The movieproc “format” is not really a file format—all of the information about the pixels is encoded in the name of the file. So the file doesn’t even need to exist on disk to use it.

You might use a movieproc as a source if you need a procedural movie object like color bars or a hold on a black or other solid color frame in in a sequence.

The syntax of the file name is a follows:

`TYPE, OPTION=VALUE,OPTION=VALUE,OPTION=VALUE.movieproc`

Above, TYPE is one of solid, smptebars, colorchart, noise, blank, black, white, grey/gray, hramp/hbramp, hwramp, or error, and OPTION and VALUE are one of those listed in the table below. A blank movieproc is one that will render no pixels but can occupy space in a sequence, and so can be used to form sequences with “holes”.

| Option | Value |
|-|-|
| start | frame number |
| end | frame number |
| fps | frames-per-second (e.g. 30 or 29.97) |
| inc | frame increment (default is 1) |
| red, green, blue | floating point value [-inf, inf] (used as one “side” for ramp types) |
| grey, gray | short hand for red=green=blue image |
| alpha | floating point value [0, 1] |
| width | Image width in pixels |
| height | Image height in pixels |
| depth | Channel Bit Depth: one of 8i, 16i, 16f, or 32f |
| interval | interval in seconds for “sync” and “flash” options below |
| audio | “sine” for continuous tone, or “sync” for once-per-interval chirp |
| freq | Audio Frequency (pitch), e.g. 440 for concert A |
| amp | Audio Amplitude [0,1] |
| rate | Audio Rate in Samples-per-second (e.g, 44100 for CD quality) |
| hpan | “animate” by shifting hpan pixels to the left each frame |
| flash | flash one frame every interval |
| filename | base64 string to spoof filename |
| attr:NAME | add an attribute named NAME to the Framebuffer with string value |

<center>*Movieproc Options*</center>

For example the following will show color bars with a 1000Hz tone:

```
smptebars,audio=sine,freq=1000,start=1,end=30,fps=30.movieproc
```

To make 100 black HD 1080 frames:

```
solid,start=1,end=100,fps=24,width=1920,height=1080.movieproc
```

To make an orange frame:

```
solid,red=1,green=.5,blue=0,width=1920,height=1080.movieproc
```

Anywhere you might use a normal file or sequence name in RV or RVIO you can use a movieproc instead.

### RED r3d

RV can read RED r3d files directly. By default, the native pixels are converted to linear space by the RED SDK and displayed in RV without any linearizing transform. If you want to use alternate decoding parameters, you can use MOVIER3D_ARGS environment variable and set it to any or all of the five options. Note, the –hdrBlendAlgorithm and –hdrBias options apply to HDRx clips.

```
shell> setenv MOVIER3D_ARGS "--videoDecodeMode <mode> --videoPixelType <type> \
--imageGammaCurve <transfer> --imageColorSpace <cs> --hdrBlendAlgorithm <blend> --hdrBias <bias>"
```

Decoding defaults to 16 bit Half quarter resolution “good” and the default color space is ACES.

If the clip is a HDRx clip, then the default hdrBlendAlgorithm option is HDRx_MAGIC_MOTION with a default hdrBias of 0.0\. To decode just FrameA for a HDRx clip, use “–hdrBlendAlgorithm HDRx_SIMPLE_BLEND –hdrBias 1” and for FrameX (the under exposed frame) use “–hdrBlendAlgorithm HDRx_SIMPLE_BLEND –hdrBias -1”.

| | |
|-|-|
| –videoDecodeMode string | Where string is one of:DECODE_FULL_RES_PREMIUMDECODE_HALF_RES_PREMIUMDECODE_HALF_RES_GOODDECODE_QUARTER_RES_GOODDECODE_EIGHT_RES_GOODDECODE_SIXTEENTH_RES_GOOD.Default is DECODE_QUARTER_RES_GOOD. |
| –videoPixelType string | Where string is one of:PixelType_16Bit_RGB_PlanarPixelType_16Bit_InterleavedPixelType_8Bit_BGRA_InterleavedPixelType_10Bit_DPX_MethodBPixelType_12Bit_BGR_InterleavedPixelType_8Bit_BGR_InterleavedPixelType_HalfFloat_RGB_InterleavedPixelType_HalfFloat_RGB_ACES_IntDefault is PixelType_HalfFloat_RGB_ACES_Int. |
| –imageGammaCurve string | Where string is one of:ImageGammaREDgamma4ImageGammaREDgamma3ImageGammaREDgamma2ImageGammaREDlogFilmImageGammaREDlogImageGammaLinearImageGammaRec709ImageGammaSRGBImageGammaLog3G12ImageGammaLog3G10Default is ImageGammaLinear. |
| –imageColorSpace string | Where string is one of:ImageColorREDWideGamutRGBImageColorDRAGONcolor2ImageColorDRAGONcolorImageColorREDcolor4ImageColorREDcolor3ImageColorREDcolor2ImageColorRec2020ImageColorRec709ImageColorSRGBImageColorAdobe1998Default is ImageColorREDcolor4. |
| –hdrBlendAlgorithm string | Where string is one of:HDRx_SIMPLE_BLENDHDRx_MAGIC_MOTIONDefault is HDRx_MAGIC_MOTION |
| –hdrBias string | Where string is a float value.Default is 0.0 |

<center>*RED R3D Raw File Reader Arguments*</center>

RED files can also be converted to EXR directly while maintaining the header metadata:

```
shell> rvio in.r3d -o out.#.exr -outparams "passthrough=RED"
```

R3D audio data is ignored by RV and RVIO.

Reading of RED R3D files supports more than one reading thread (i.e. Preferences window “Caching” tab “Reader Threads”). We suggest using a value thats no more than the number of cores on the playback machine. Please note that if you “kill -9” (send a SIGKILL signal to) the RV process after having played back a R3D file, you will need to check for defunct “redsidecar” reader processes and terminate them.

## Image File Formats

Each platform which RV runs on has its own selection of image formats. There are few important ones which are implemented across all platforms. Some of the most important formats are discussed in this chapter.

### OpenEXR

OpenEXR (EXR) is a high dynamic range floating point file format developed at ILM. It can store both 32 and 16 bit “half” floating point values with or without compression. RV supports the EXR half float type natively and when the GPU is capable, will render using type half type directly. RVIO is capable of converting to and from the half and full float formats.

The EXR format is extremely flexible, capable of holding everything from multiple views (for stereo) to rendered layers like isolated diffuse and specular components as separate images. In addition it’s possible to store subsampled chroma images or combinations of all the above.

There have been at least two important revisions to the original OpenEXR specification, one the “multi-view” spec adds official support for top-level “view” objects that contain channels, and the most recent, the “multi-part” spec adjusts the file format so that groups of channels can be stored in discrete sections (“parts”) for efficient I/O. RV supports all varieties of EXR file supported by the latest specifications, but attempts to hide some of the resulting complexity from the user, as discussed below.

#### Multiple Views

Multiple view EXR files as defined by the Weta Multiview Extension are supported by RV. When in stereo mode, RV will look for views called “left” and “right” by default and can be programmatically told to use other channels (see the Reference Manual).

You can also select one or more views in the UI to be loaded specifically when not in stereo mode. In stereo mode if you specify two views those will become the left and right.

RV defaults to loading the default (or first) EXR layer from the view. The EXR views are independent of EXR layers which are described below—there can be multiple views each of which has multiple layers (or vice versa if you prefer to think of it that way).

RV will recognize the file extensions “exr”, “sxr” (stereo exr), or “openexr” as being OpenEXR files. Stereo views may be stored as either “exr” or “sxr”; RV does not distinguish between the two extensions.

#### Layers

A layer in EXR terminology is a collection of channels which share a common channel name prefix separated by a dot character. Although EXR layers can have sub-layers and so on, in RV the layer hierarchy is flattened to a single level. So for example, an EXR channel in a traditional multi-view EXR file (multi-part files are discussed below), might have a channel called “left.keyLight.Diffuse.R”. In RV’s simplified usage, the channel “R” is a member of the layer “keyLight.Diffuse”, which is a member of the view “left”.

EXR layers are usually used to store components of images output by a renderer like Pixar’s prman or Mental Image’s Mental Ray. Often these layers are recombined in compositing software like Nuke which can handle the internal structure of the EXR file. This makes it easy for a compositor to control render output at a fine level to match it into a shot. Note that this not how EXR views are used—they are used for indicating stereo eyes (for examples) and each view may itself contain multiple EXR layers.

RV initially will load the default layer (the one that has no name) or the first layer it finds. If this layer has R, G, B, A, Z, Y, RY, or BY channels, these will be assigned accordingly. If there are no obvious channel assignments to be made to the red, green, and blue channels, RV will take the first four channels it finds in the layer. If there are additional channels, you can assign these explicitly using the channel remap function in the UI under Image→Remap Source Image Channels.

You can view alternate layers by selecting them in the Session Manager, or by selecting a layer on the command line.

#### Y RY BY Images and Subsampling.

By default, RV will read EXR files as planar images. Normally this distinction does not have any real effect at the user level, but in the case of Y RY BY images — which can be sub-sampled — it can have a big impact on playback performance. EXR has two special lossy compression schemes, B44 and B44A, which allow fast decode of high dynamic range imagery. B44 maintains a fixed size file regardless of the contents while B44A can potentially make smaller file sizes. As of OpenEXR v2.2.0, two further lossy DCT compression schemes were added i.e. DWAA (based on 32 scanlines) and DWAB (based on 256 scanlines). The level compression for DWAA and DWAB can be set through the &#8216;-quality &lt;compression level value&gt;’ option in rvio when writing out EXR files. This value is stored in the exr header (single/multipart) as a float attribute called &#8216;dwaCompressionLevel’ and defaults to 45 for DWAA and DWAB.

When used with Y RY BY images with sub-sampled chroma (the BY and RY channels) RV will use the GPU to resample the chroma on the card resulting in faster throughput. When coupled with one or more multi-core CPUs, RV can get good direct from disk performance for these types of images while keeping the HDR information in tact [<sup>17</sup>](#footnote_17) . At some resolutions, RV can even play back stereo HDR imagery in real-time from disk when used with the correct hardware.

#### Chromaticities

EXR files may have chromaticities (primaries) included in the image attributes. If RV sees the **Color/Primaries** attribute, it will apply the corresponding transform to the Rec 709 primaries by default. You can turn off this behavior by selecting Color→Ignore File Primaries to disable the transform.

#### Channel Inheritance

Some programs may assume channels should be “inherited” in EXR files. For example, a renderer may write a single alpha channel in the default layer and exclude redundant alpha channels from additional layers in the file like diffuse and specular. The idea is that these layers will share the default alpha during compositing.

RV can attempt to aggregate channels assumed to be related like this by using either the command line option -exrInherit or by setting the flag in preferences (under the OpenEXR format).

#### Data/Display Window Handling

How an EXR image is displayed on screen, under certain data/display window overlap permutations, can vary across commercial and/or in-house viewing tools. To accommodate this and allow RV to emulate these differing behaviors, we provide several exr format preferences; see the table below for typical settings.

The two OpenEXR preferences, found under Preferences-Format-OpenEXR, that define RV’s data/display window handling behavior are -exrReadWindow and -exrReadWindowIsDisplayWindow. The flag -exrReadWindow specifies how the final data/display window (i.e ReadWindow) is defined. The choices are “Data Window”, “Display Window”, “Data Window Inside Display Window” and “Union of Data and Display Window”. In addition the flag -exrReadWindowIsDisplayWindow maybe optionally set to always make the ReadWindow the EXR display window; otherwise the display window is determined by source’s EXR display window attributes.

<center>*OpenEXR format settings that emulate data/display window handling of various tools*&ast;</center>

| **Read Window** | **Read Window Is Display Window** | **Tool** |
|-|-|-|
| Data Window | Checked | OSX Preview, Adobe Photoshop |
| Display Window | Not applicable | Nuke, exrdisplay |
| Data Window Inside Display Window | Not applicable | |
| Union of Data and Display Window | Checked | Renderman it, exrdisplay -w |

&ast; = Subject to change by the vendor.

#### Parts

As of OpenEXR version 2.0, EXR files can be written in separate sections, called “parts”. Each part has it’s own header, and the underlying OpenEXR API can quickly skip to parts requested by the reader. Parts can contain layered and unlayered channels and be associated with views, but parts have names and so can also act as “layers” in the sense that unique parts can contain channels of the same name.

In order to merge these possibly multiple and simultaneous uses of “parts” into the standard view/layer/channel hierarchy, RV subsumes EXR “parts” into the definition of “layer” when necessary. That is, as far as RV is concerned, a fully-specified channel name always looks like **view.layer.channel**, where (in the case of an EXR file) the three period-separated components of the name have these meanings:

| | |
|-|-|
| **view** | The name of the stereo view. This may be missing or “default” for “the default view”. The view name cannot contain a “.” Example: “left”, “right”, “center”, etc. |
| **layer** | This component may include part names as well as traditional EXR layer names. The rule is that if there are no channel-name conflicts within a single view, the part names will be ignored (since they are not necessary to distinguish the channels), if there **is** a channel-name conflict, the part names maybe incorporated into the layer names. Sub-layers are also included. To be concrete, a channel called “Diffuse.R” stored in a part called “keyLight” is considered to be a member of a layer called “keyLight.Diffuse” if the channel “Diffuse.R” also appears in another part within the same view. |
| **channel** | The last component of a traditional EXR channel name, containing no “.” Example: “R”, “G”, “B”, “A”, “Z”, etc. |

<center>*Components of a fully-qualified channel name.*</center>

NB: One comment on performance; we have observed uncached playback FPS speedups of between 2-3x (OSX/Linux/Windows) with multipart exr files over single part exr files for deep channeled images.

### TIFF

TIFF files come in many flavors some of which are rarely used. RV supports a useful subset of all possible TIFF files. This includes 32 bit floating point and multiple channels (beyond four) in both tiled and scanline. RV can read planar and interleaved TIFF files, but currently only reads the first image directory if there are more than one.

RV will read all TIFF tags including EXIF tags and present them as image attributes.

### DPX and Cineon

RV and RVIO currently support 8 and16 bit, and the common 10 and 12 bit DPX and 10 bit Cineon files reading direct from disk on all platforms. The standard header fields are read and reported if they contain useful information (e.g., Motion Picture and TV fields). We do not currently support any of the vendor headers.

RV supports the linear, log, and Rec. 709 transfer functions for DPX natively and others through the use of LUTs.

RV decodes DPX and Cineon to 8 bit integer per channel by default. However, the reader can be configured from the command line or preferences to use 16 bit if needed. In addition the reader can use either planar or interleaved pixel formats. We have found that the combination of OS and hardware determines which format is fastest for playback, but we currently recommend RGB8_PLANAR on systems that can use OpenGL Pixel Buffer Objects (PBOs) and RGBA8 on systems that cannot. If you opt for 16 bit pixels, use the RGB16_PLANAR as the pixel format on PBO equipped hardware for maximum throughput.

For best color fidelity use RV’s built in Cineon Log→Linear option and sRGB display (or a particular display LUT if available). This option decodes the log space pixels directly to linear without interpolation inside a hardware shader and results in the full [0,  ∼ 13.5] range.

RVIO decodes Cineon and DPX to 16 bit integer by default.

The DPX and Cineon writers are both currently limited to 10 bit output.

### IFF (ILBM)

The IFF image format commonly created by Maya or Shake is supported by RV including the 32 bit float version.

### JPEG

RV can read JPEG natively as Y U V or R G B formats. The reader can collect any EXIF tags and pass them along as image attributes. The reader is limited to 8 bits per channel files. Like OpenEXR, DPX, and Cineon, JPEG there is a choice of I/O method with JPEG images.

### ARRI Alexa

The ARRI raw LogC or LogC-Film encoded files (.ari) can be read directly by RV and RVIO. In addition, non ari files with a LogC or LogC-Film curve applied (e.g. DPX) can be viewed in RV using a “generic” LogC or LogC-Film when no information about the transfer function is available; an exposure index (EI) value of 800 is assumed for the LogC/LogC-Film parameters in this case.

RV computes the LogC/LogC-Film curve parameters directly from the exposure index (EI) in the file’s metadata or from the “–iso” IOARI_ARGS parameter value which is used to override the file’s metadata EI value. No LUTs are required. These EI dependant LogC parameter values are noted in the RV imageinfo attributes “ColorSpace/LogC&lt;something&gt;”.

The color is transformed from the decode colorspace (which defaults to choice Arri Wide Gamut) to Rec709 primaries which is RV’s internal working color space. The decode colorspace can be a colorspace other than LogC_WideGamut; the choices are listed in the table below. There are two variants for LogC_WideGamut. One is more colormetrically (scene referred) accurate than the other. The colorimetric mode is more appropriate for VFX use than say digital post production. The default behavior is to use the non-colorimetric version of the Wide Gamut to Rec709 transform which is preferred in digital post production (e.g. transcoding to ProRes). The IOARI_ARGS parameter “–enableColorimetricMode” lets you make this choice by enabling the colorimetric version of the Wide Gamut to Rec709 transform when set to &#8216;1’. This parameter defaults to &#8216;0’ otherwise.

For more information about color processing one can refer to the ARRI documentation on “Color Management for Alexa V3” and “Alexa Usage in VFX”.

If you use RVIO to convert the raw images to EXR or similar formats which can hold the full dynamic range all of the camera’s data should be preserved. In addition, you can pass all the raw metadata as well.

For example:

```
shell> rvio in.ari -inlogc -o out.exr -outparams "passthrough=ARRI"
```

You can control some aspects of the ARRI decoder by passing in parameter values to the io_ari plugin via an environment variable: `IOARI_ARGS.`

Theses parameters are support in RV version 6.x onwards and reflect some of the choices provided by ArriRawSDK v5.3 or later. Example:

```
shell> setenv IOARI_ARGS "--colorspace LogC_WideGamut --enableColorimetricMode 1 --debayer ADA_5_SW --threads 8 --downScaleMode QUAD_HD_FROM_2880PX"
```

The value of the variable is command line like arguments:

| | |
|-|-|
| –ioMethod int | 0=standard, 1=buffered, 2=unbuffered, 3=MemoryMap, 4=AsyncBuffered, 5=AsyncUnbuffered, default=2 |
| –ioSize int | IO packet size in bytes for asynchronous I/O |
| –ioMaxAsync int | Maximum number of asynchronous in-flight requests |
| –debayer string | One of “ADA_1_HW”, “ADA_2_SW”, “ADA_3_SW”, “ADA_3_HW”, “ADA_5_SW” or “Fast”. The default is “ADA_5_SW”. This choice is displayed in the imageinfo by the attribute “Arri-Decoder/DebayerMode”. |
| –colorspace string | One of “LogC_WideGamut”, “LogC_Film”, “Video_ITU709”, “Video_ITU2020”, “Video_DCI_D60”, “Video_DCI_D65”, “Video_P3”, “LogC_CameraNative” or “SceneLinear_Aces”. The defauilt is “LogC_WideGamut”. This choice is displayed in the imageinfo by the attribute “Arri-Decoder/ColorSpace”. |
| –downScaleMode string | Down/Upscale scale mode choice. See table 14.5 below. This choice is displayed in the imageinfo by the attribute “Arri-Decoder/DownscaleMode”. |
| –anamorphFactor float | Anamorphic squeeze factor i.e. 1.0 for spheric footage, 1.3 or 2.0 for anamorphic images. This value is displayed in the imageinfo by the attribute “PixelAspectRatio”. |
| –sharpness int | The sharpness with which the footage is downscaled i.e. a value between 0 and 300, 100 for original sharpness. This value is displayed in the imageinfo by the attribute “Arri-Decoder/Sharpness”. |
| –iso int | Override the file metadata ISO rating i.e. a value from 50 up to 3200 (depending on processing version) for ALEXA, from 50 to 500 for D21. This value is displayed in the imageinfo by the attribute “Arri-Decoder/ISO”. |
| –enableColorimetricMode int | If set to '1' uses the more colormetric accurate LogC_WideGamut to Rec709 primaries color transform during linearization. In this mode the colorspace primaries used for WideGamut to Rec709 conversion are defined by the imageinfo attributes “ColorSpace/ <White/Red/Green/Blue>/Primary”. If set to '0' (the default), the WideGamut to XYZ matrix used for WideGamut to Rec709 conversion is defined by the imageinfo attribute “ColorSpace/ RGBToXYZMatrix”. |
| –threads int | Sets the num of threads/cpus to use by the SDK's raw decoder. Defaults to 75% of the max number of avail threads/cpus. This value is displayed in the imageinfo by the attribute “Arri-Decoder/NumCPUs”. |
| –proxyFactor int | Value of 1, 2, or 3 for faster proxy decoding. |

<center>*ARRI Raw File Reader Arguments*</center>

<center>*ARRI Down Scale Mode Choices*</center>

| | |
|-|-|
| NATIVE_3414PX | native sensor pixel count for certain cameras |
| NATIVE_2880PX | native sensor pixel count |
| NATIVE_2868PX | number of pixels used in SUP 7.0 2K mode |
| NATIVE_2578PX | number of pixels used in SUP 10.0 cropped 4:3 mode |
| NATIVE_6560PX | native format for ALEXA65 |
| NATIVE_5120PX | native format for ALEXA65, sensor mode 5k |
| NATIVE_4320PX | native format for ALEXA65, sensor mode 4.3k |
| NATIVE_3168PX | native format for ALEXA SXT ARRIRAW 3.2K |
| NATIVE_3424PX | native format for ALEXA OpenGate, full sensor readout |
| NATIVE_2592PX | native format for 4:3 cropped, full container content |
| NATIVE_3200PX | native format for ALEXA SXT ARRIRAW 3.2K framegrabs on SD card |
| NATIVE_1920PX | native format for ALEXA Mini 8:9 |
| SD_FROM_2880PX | 768px image width |
| HD_1_78_FROM_3414PX | 16:9 cropped to 1920 x 1080 |
| HD_1_85_FROM_3414PX | 16:9 cropped to 1920 x 1038 |
| HD_2_39_FROM_3414PX | 16:9 cropped to 1920 x 804 |
| HD_1_78_FROM_2880PX | HD standard downscaling with center crop from 4:3 to 16:9 if necessary. is equivalent to HD_FROM_2880PX for a non 4:3 camera/image |
| HD_2_39_FROM_2880PX | HD downscaling including anamorphotic desqueeze, only usable with 2.0 anamorphotic footage |
| HD_2_39_FROM_2578PX | HD downscaling including anamorphotic desqueeze, only usable with 2.0 anamorphotic footage |
| HD_FROM_2880PX | 1920px image width |
| HD_FROM_6560PX | HD downscaling for ALEXA65 OpenGate |
| HD_2_39_FROM_6560PX | HD downscaling for ALEXA65 OpenGate cropped to 1920px x 804px |
| HD_1_85_FROM_6560PX | HD downscaling for ALEXA65 OpenGate cropped to 1920px x 1038px |
| HD_1_78_FROM_6560PX | HD downscaling for ALEXA65 OpenGate cropped to 1920px x 1080px |
| HD_FROM_5120PX | HD downscaling for ALEXA65 16:9 |
| HD_2_39_FROM_5120PX | HD downscaling for ALEXA65 16:9 cropped to 1920px x 804px |
| HD_1_85_FROM_5120PX | HD downscaling for ALEXA65 16:9 cropped to 1920px x 1038px |
| HD_1_78_FROM_5120PX | HD downscaling for ALEXA65 16:9 cropped to 1920px x 1080px |
| HD_FROM_4320PX | HD downscaling for ALEXA65 3:2 |
| HD_2_39_FROM_4320PX | HD downscaling for ALEXA65 3:2 cropped to 1920px x 804px |
| HD_1_85_FROM_4320PX | HD downscaling for ALEXA65 3:2 cropped to 1920px x 1038px |
| HD_1_78_FROM_4320PX | HD downscaling for ALEXA65 3:2 cropped to 1920px x 1080px |
| HD_FROM_3168PX | HD downscaling for ALEXA SXT to 1920px x 1080px |
| HD_FROM_3200PX | HD downscaling for ALEXA SXT & AMIRA framegrabs to 1920px x 1080px |
| HD_FROM_1920PX | HD downscaling for Alexa Mini 8:9 to 1920px x 1080 px |
| TWO_K_1_78_FROM_3414PX | 5:3 cropped to 2048 x 1152 |
| TWO_K_DCI_1_85_FROM_3414PX | 41:24 cropped to 1998 x 1080 |
| TWO_K_1_85_FROM_3414PX | 5:3 cropped to 2048 x 1108 |
| TWO_K_2_39_FROM_3414PX | 5:3 cropped to 2048 x 858 |
| TWO_K_FROM_2880PX | 2K standard downscaling |
| TWO_K_FROM_2868PX | 2K downscaling used in SUP 7.0 2K mode |
| TWO_K_1_78_FROM_2880PX | 2K standard downscaling with center crop from 4:3 to 16:9 if necessary. is equivalent to TWO_K_FROM_2880PX for a non 4:3 camera/image |
| TWO_K_1_78_FROM_2868PX | 2K downscaling used in SUP 7.0 2K mode with center crop from 4:3 to 16:9 if necessary. is equivalent to TWO_K_FROM_2880PX for a non 4:3 camera/image |
| TWO_K_2_39_FROM_2880PX | 2K downscaling including anamorphotic desqueeze, only usable with 1.3x or 2.0 anamorphotic footage |
| TWO_K_DCI_1_85_FROM_2880PX | downscaling including anamorphotic desqueeze and crop to 1998 x 1080, only usable with 1.3x anamorphotic footage |
| TWO_K_2_39_FROM_2578PX | 2K downscaling including anamorphotic desqueeze, only usable with 2.0 anamorphotic footage |
| TWO_K_FROM_6560PX | 2k downscaling for ALEXA65 OpenGate |
| TWO_K_2_39_FROM_6560PX | 2k downscaling for ALEXA65 OpenGate cropped to 2048px x 858px |
| TWO_K_1_85_FROM_6560PX | 2k downscaling for ALEXA65 OpenGate cropped to 2048px x 1108px |
| TWO_K_DCI_1_85_FROM_6560PX | 2k DCI downscaling for ALEXA65 OpenGate cropped to 1998px x 1080px |
| TWO_K_1_78_FROM_6560PX | 2k downscaling for ALEXA65 OpenGate cropped to 2048px x 1152px |
| TWO_K_FROM_5120PX | 2k downscaling for ALEXA65 16:9 |
| TWO_K_2_39_FROM_5120PX | 2k downscaling for ALEXA65 16:9 cropped to 2048px x 858px |
| TWO_K_1_85_FROM_5120PX | 2k downscaling for ALEXA65 16:9 cropped to 2048px x 1108px |
| TWO_K_DCI_1_85_FROM_5120PX | 2k DCI downscaling for ALEXA65 16:9 cropped to 1998px x 1080px |
| TWO_K_1_78_FROM_5120PX | 2k downscaling for ALEXA65 16:9 cropped to 2048px x 1152px |
| TWO_K_FROM_4320PX | 2k downscaling for ALEXA65 3:2 |
| TWO_K_2_39_FROM_4320PX | 2k downscaling for ALEXA65 3:2 cropped to 2048px x 858px |
| TWO_K_1_85_FROM_4320PX | 2k downscaling for ALEXA65 3:2 cropped to 2048px x 1108px |
| TWO_K_DCI_1_85_FROM_4320PX | 2k DCI downscaling for ALEXA65 3:2 cropped to 1998px x 1080px |
| TWO_K_1_78_FROM_4320PX | 2k downscaling for ALEXA65 3:2 cropped to 2048px x 1152px |
| TWO_K_1_78_FROM_4320PX | 2k downscaling for ALEXA65 3:2 cropped to 2048px x 1152px |
| TWO_K_FROM_3168PX | 2k downscaling for ALEXA SXT to 2048px x 1152px |
| TWO_K_FROM_3200PX | 2k downscaling for ALEXA SXT & AMIRA framegrabs to 2048px x 1152px |
| QUAD_HD_1_85_FROM_3414PX | 8:9 cropped to 3840 x 2076 |
| QUAD_HD_2_39_FROM_3414PX | 8:9 cropped to 3840 x 1608 |
| QUAD_HD_2_39_FROM_2880PX | upscaling including anamorphotic desqueeze and crop to to 3840 x 1716, only usable with 2.0 anamorphotic footage |
| QUAD_HD_2_39_FROM_2578PX | upscaling including anamorphotic desqueeze and crop to to 3840 x 1716, only usable with 2.0 anamorphotic footage |
| QUAD_HD_FROM_2880PX | UHD upscaling to 3840px |
| QUAD_HD_FROM_6560PX | UHD downscaling for ALEXA65 OpenGate |
| QUAD_HD_2_39_FROM_6560PX | UHD downscaling for ALEXA65 OpenGate cropped to 3840px x 1610px |
| QUAD_HD_1_85_FROM_6560PX | UHD downscaling for ALEXA65 OpenGate cropped to 3840px x 2076px |
| QUAD_HD_1_78_FROM_6560PX | UHD downscaling for ALEXA65 16:9 |
| QUAD_HD_FROM_5120PX | UHD downscaling for ALEXA65 16:9 cropped to 3840px x 1610px |
| QUAD_HD_2_39_FROM_5120PX | UHD downscaling for ALEXA65 16:9 cropped to 3840px x 2076px |
| QUAD_HD_1_85_FROM_5120PX | UHD downscaling for ALEXA65 16:9 cropped to 3840px x 2160px |
| QUAD_HD_1_78_FROM_5120PX | UHD downscaling for ALEXA65 3:2 |
| QUAD_HD_FROM_4320PX | UHD downscaling for ALEXA65 3:2 cropped to 3840px x 1610px |
| QUAD_HD_2_39_FROM_4320PX | UHD downscaling for ALEXA65 3:2 cropped to 3840px x 2076px |
| QUAD_HD_1_85_FROM_4320PX | UHD downscaling for ALEXA65 3:2 cropped to 3840px x 2160px |
| QUAD_HD_1_78_FROM_4320PX | UHD upscaling to 3840px |
| QUAD_HD_FROM_3168PX | UHD upscaling for ALEXA SXT to 3840px x 2160px |
| QUAD_HD_FROM_3200PX | UHD upscaling for ALEXA SXT & AMIRA framegrabs to 3840px x 2160px |
| FOUR_K_DCI_1_78_FROM_3414PX | 8:9 cropped to 3840 x 2160 is equal to quad HD |
| FOUR_K_1_78_FROM_3414PX | 5:6 cropped to 4096 x 2304 |
| FOUR_K_DCI_1_85_FROM_3414PX | 41:48 cropped to 3996 x 2160 |
| FOUR_K_1_85_FROM_3414PX | 5:6 cropped to 4096 x 2214 |
| FOUR_K_2_39_FROM_3414PX | 5:6 cropped to 4096 x 1716. With 2.0 anamorphotic footage |
| FOUR_K_DCI_1_78_FROM_2880PX | upscaling including anamorphotic desqueeze and crop to to 3840 x 2160, only usable with 1.3x anamorphotic footage |
| FOUR_K_DCI_1_85_FROM_2880PX | upscaling including anamorphotic desqueeze and crop to to 3996 x 2160, only usable with 1.3x anamorphotic footage |
| FOUR_K_2_39_FROM_2880PX | upscaling including anamorphotic desqueeze and crop to to 4096 x 1716, only usable with 1.3x or 2.0 anamorphotic footage |
| FOUR_K_2_39_FROM_2578PX | upscaling including anamorphotic desqueeze and crop to to 4096 x 1716, only usable with 2.0 anamorphotic footage |
| FOUR_K_FROM_2880PX | 4k upscaling to 4096px width |
| FOUR_K_FROM_6560PX | 4k downscaling for ALEXA65 OpenGate |
| FOUR_K_2_39_FROM_6560PX | 4k downscaling for ALEXA65 OpenGate cropped to 4096px x 1716px |
| FOUR_K_1_85_FROM_6560PX | 4k downscaling for ALEXA65 OpenGate cropped to 4096px x 2214px |
| FOUR_K_DCI_1_85_FROM_6560PX | 4k DCI downscaling for ALEXA65 OpenGate cropped to 3996px x 2160px |
| FOUR_K_1_78_FROM_6560PX | 4k downscaling for ALEXA65 OpenGate cropped to 4096px x 2304px |
| FOUR_K_FROM_5120PX | 4k downscaling for ALEXA65 16:9 |
| FOUR_K_2_39_FROM_5120PX | 4k downscaling for ALEXA65 16:9 cropped to 4096px x 1716px |
| FOUR_K_1_85_FROM_5120PX | 4k downscaling for ALEXA65 16:9 cropped to 4096px x 2214px |
| FOUR_K_DCI_1_85_FROM_5120PX | 4k DCI downscaling for ALEXA65 16:9 cropped to 3996px x 2160px |
| FOUR_K_1_78_FROM_5120PX | 4k downscaling for ALEXA65 16:9 cropped to 4096px x 2304px |
| FOUR_K_FROM_4320PX | 4k downscaling for ALEXA65 3:2 |
| FOUR_K_2_39_FROM_4320PX | 4k downscaling for ALEXA65 3:2 cropped to 4096px x 1716px |
| FOUR_K_1_85_FROM_4320PX | 4k downscaling for ALEXA65 3:2 cropped to 4096px x 2214px |
| FOUR_K_DCI_1_85_FROM_4320PX | 4k DCI downscaling for ALEXA65 3:2 cropped to 3996px x 2160px |
| FOUR_K_1_78_FROM_4320PX | 4k downscaling for ALEXA65 3:2 cropped to 4096px x 2304px |
| FOUR_K_FROM_3168PX | 4k upscaling for ALEXA SXT to 4096px x 2304px |
| FOUR_K_FROM_3200PX | 4k upscaling for ALEXA SXT & AMIRA framegrabs to 4096px x 2304px |

### RAW DSLR Camera Formats

There are a number of camera vendor specific formats which RV can read through RV’s cross platform image plugin io_raw. This plugin uses the open src package LibRAW. The table below list some of the common raw formats that are read with this plugin.

<center>*Supported RAW formats*</center>

| **File Extension** | **File Format** |
|-|-|
| .arw | Sony/Minolta RAW |
| .cr2 | Canon RAW 2 |
| .crw | Canon RAW |
| .dng | Digital NeGative |
| .nef | Nikon Electronic Format |
| .orf | Olympus RAW |
| .pef | Pentax RAW |
| .ptx | Pentax RAW 2 |
| .raf | Fuji RAW |
| .rdc | Ricoh RAW |
| .rmf | Canon Raw Media Format |

## Audio File Formats

RV supports a number of basic uncompressed audio file formats across platforms. On Windows and OS X a number of compressed formats may be supported. Currently use of Microsoft wave files and Apple’s AIFF formats are the best bet for cross platform use. RV does support multichannel audio files for playback to multichannel audio devices/SDI audio. (see Appendix [J](j-supported-multichannel-audio-layouts.html).

## Simple ASCII EDL Format

Each line of the ASCII file is either blank, a comment, or an edit event. A comment starts with a &#8216;#’ character and continues until the end of a line. A comment can appear on the same line as an edit event.

The format of an edit event is:

```
"SOURCE" START END
```

where SOURCE is a the path to a logical source movie such as:

```
"/some/path/to/foo.mov"
"/some/path/to/bar.1-100#.exr"
"/some/other_path/baz.1-100#.exr"
```

Note that the SOURCE name must always be in double quotes. If the path includes spaces, you do not need to use special escape characters to make sure they are accepted. So the following is OK:

```
"/some/place with spaces/foo.mov"
```

START and END are frame numbers in the movie. Note that START is the first frame to be include in the clip, and END is the last frame to be included (not, as in some edl formats, the frame **after** the last frame). For QuickTime .mov files or .avi files, the first frame of the file is frame 1.

Here’s an example .rvedl file:

```
 #
 # 4 source movies
 #

 "/movies/foo.mov" 1 100
 "/movies/bar.mov" 20 50
 "/movies/render.1-100#.exr" 25 100
 "/movies/with a space.#.exr" 1 25
```

<sup>17</sup> <a name="footnote_17"></a>The OpenEXR file will only use B44 or B44A with half float images currently. 32 bit float images will not typically get as good performance.
