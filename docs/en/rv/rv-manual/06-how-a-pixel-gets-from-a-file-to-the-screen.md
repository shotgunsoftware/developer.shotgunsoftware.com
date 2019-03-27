---
layout: default
title: How a Pixel Gets from a File to the Screen
permalink: /rv/rv-manual/06-how-a-pixel-gets-from-a-file-to-the-screen/
lang: en
---

# How a Pixel Gets from a File to the Screen

RV has a well defined image processing pipeline which is implemented as a combination of software and hardware (using the GPU when possible). The figure below shows the pixel pipeline.

<center>![RV Pixel Pipeline.](../../../../images/rv/pipeline_diagram_4_0.png)</center>

<center>*RV Pixel Pipeline.*</center>

## Image Layers

Each image source may be composed of one or more layers. Layers may come from multiple files, or a single file if the file format supports it or a combination of the two. For example a stereo source can be constructed from a left and right movie file; in that case each file is a layer. Alternately, layers may come from a single file as would be the case with a stereo QuickTime file or EXR images with left and right layers.

An image source may have any number of layers. By default, only the first layer is visible in RV unless an operation exposes the additional layers.

### Stereo Layers

RV has a number of stereo viewing options which render image layers to a left and right eye image. The left and right eye images are both layers. RV doesn’t require any specific method of storing stereo images: you can store them in a single movie file as multiple tracks, as multiple movie files, or as multiple image sequences. You can even have one eye be a completely different format than the other if necessary. Stereo viewing is discussed in Chapter [Stereo Viewing](stereo-viewing.html).

## Image Attributes

RV tries to read as many image attributes as possible from the file. RV may also add attributes to the image to indicate things like pixel aspect ratio, alpha type, uncrop regions (data and display windows) and to indicate the color space the pixels are in. The image info window in the user interface shows all of the relevant image attributes.

Some of the attributes are treated as special cases and can have an effect on rendering. Internally, RV will recognize and use the **ColorSpace/Primary** attributes automatically. Other **ColorSpace** attributes are used by the default source setup package (See Reference Manual) to set file to linear properties correctly. For example, if the **ColorSpace/Transfer** attribute has the value “Kodak Log”, the default source setup function will automatically turn on the Kodak log to linear function for that source.

Image attributes can be saved as a text file directly from the UI (File→Export→Image Attributes), viewed interactively with the Tools→Image Info widget, or using the rvls program from the command line.



| **Attribute** | **How It’s Used** |
|-|-|
| ColorSpace/Primaries | Documents the name of the primary space if it has one |
| ColorSpace/Transfer | Contains the name of the transfer function used to convert non-linear R G B values to linear R G B values. This is used by the source setup script as a default non-linear to linear conversion. |
| ColorSpace/Conversion | If the image is encoded as a variant of luminance + chroma this attribute documents the name of the color conversion (or space) required to convert to non-linear R G B values |
| ColorSpace/ConversionMatrix | If the luminance + chroma conversion matrix is explicitly given, this attribute will contain it |
| ColorSpace/Gamma | If the image is gamma encoded the correction gamma is stored here |
| ColorSpace/Black Point | Explicit value for Kodak log to linear conversion if it exists or related functions which require a black/white point |
| ColorSpace/White Point | |
| ColorSpace/Rolloff | Explicit value for Kodak log to linear conversion |
| ColorSpace/Red Primary | Explicit primary values. These are used directly by the renderer unless told to ignore them. |
| ColorSpace/Green Primary | |
| ColorSpace/Blue Primary | |
| ColorSpace/White Primary | |
| ColorSpace/AdoptedNeutral | Indicates adopted color temperature (white point). |
| ColorSpace/RGBtoXYZMatrix | Explicit color space conversion matrix. This may be used instead of the primary attributes to determine a conversion to the RGB working space. |
| ColorSpace/LogCBlackSignal | ARRI LogC black signal. Black will be mapped to this value. The default is 0. |
| ColorSpace/LogCEncodingOffset | Derived from camera parameters. |
| ColorSpace/LogCEncodingGain | Derived from camera parameters. |
| ColorSpace/LogCGraySignal | The value mapped to 18% grey. The default is 0.18. |
| ColorSpace/LogCBlackOffset | Derived from camera parameters. |
| ColorSpace/LogCLinearSlope | Derived from camera parameters. |
| ColorSpace/LogCLinearOffset | Derived from camera parameters. |
| ColorSpace/LogCCutPoint | Indirectly determines the final linear/non-linear cut off point along with other parameters. |
| | |
| ColorSpace/ICC Profile Name | The name and data of an embedded ICC profile |
| ColorSpace/ICC Profile Data | |
| PixelAspectRatio | Pixel aspect ratio from file |
| DataWindowSize | Uncrop parameters if they appeared in a file |
| DataWindowOrigin | |
| DisplayWindowSize | |
| DisplayWindowOrigin | |

<center>*Basic Special Image Attributes*</center>

## Image Channels

RV potentially does a great deal of data conversion between reading a file and rendering an image on your display device. In some cases, you will want to have control over this process so it’s important to understand what’s occurring internally. For example, when RV reads a typical RGB TIFF file, you can assume the internal representation is a direct mapping from the data in the file. If, on the other hand, RV is reading an EXR file with A, B, G, T, and Z channels, and you are interested in the contents of the Z channel, you will need to tell RV specifically how to map the image data to an RGBA pixel.

To see what channels an image has in it and what channels RV has decided to use for display you can select Tools→&ast;Image Info in the menu bar. The first two items displayed tell you the internal image format. In some cases you will see an additional item called *ChannelNamesInFile* which may show not only R, G, B channels, but additional channels in the file that are not being shown.

RV stores images using between one and four channels. The channels are always the same data type and precision for a given image. If an image file on disk contains channels with differing precision or data type, the reader will choose the best four channels to map to RGBA (or fewer channels) and a data type and precision that best conserves the information present in the file. If there is no particular set of channels in the image that make sense to map to an internal RGBA image, RV will arbitrarily map up to the first four channels in order. By default, RV will interpret channel data as shown in the table below.

| **# of Channels** | **Names** | **RGBA Mapping** |
|-|-|-|
| 1 | Y | YYY1 |
| 2 | Y, A | YYYA |
| 3 | R, G, B | RGB1 |
| 4 | R, G, B, A | RGBA |

<center>*Mapping of File Channels to Display Channels*</center>

<center>*Default interpretation of channels and how they are mapped to display RGBA. “1” means that the display channel is filled with the value 1.0\. “Y” is luminance (a scalar image).*</center>

When reading an image type that contains pixel data that is not directly mappable to RGB data (like YUV data), most of RV’s image readers will automatically convert the data to RGB. This is the case for JPEG, and related image formats (QuickTime movies with JPEG compression for example). If the pixel data is not converted from YUV to RGB, RV will convert the pixels to RGB in hardware (if possible).

### Precision

RV natively handles both integer and floating point images. When one of RV’s image readers decides a precision and data type for an image, all of its channels are converted to that type internally.

| **Channel Data Type** | **Display Range** | **Relative Memory Consumption** |
|-|-|-|
| 8 bit int | [0.0 , 1.0] | 1 |
| 16 bit int | [0.0 , 1.0] | 2 |
| 16 bit float | [ - inf , inf ] | 2 |
| 32 bit float | [ - inf , inf ] | 4 |

<center>*Characteristics of Channel Data Types.*</center>

RV lets you modify how the images are stored internally. This ability is important because different internal formats can require different amounts of memory. In some cases you will want to reduce or increase that memory requirement to fit more images into a cache or for faster or longer playback.

You can force RV to use a specific precision in the interface Color→Color Resolution menu. There are two options here: (1) whether or not to allow floating point and (2) the maximum bit depth to use.

In the RV image processing DAG, precision is controlled by the Format node. There are two properties which determine the behavior: **color.maxBitDepth** and **color.allowFloatingPoint**.

### Channel Remapping

RV provides a few similar functions which allow you to remap image channels to display channels. The most general method is called Channel Remapping.

When Channel Remapping is active, RV reads all of the channel data in an image. This may result in images with too many channels internally (five or more), so RV will choose four channels to map to RGBA.

You specify exactly which channels RV will choose and what order they should be in. The easiest way to accomplish this is in the user interface. By executing Tools→Remap Source Image Channels..., you can type in the names of the channels you want mapped to RGBA separated by commas. Using the previous example of an EXR with A, B, G, R, Z channels and you’d like to see Z as alpha, you could type in R,G,B,Z when prompted. If you’d like to see the value of Z as a greyscale image, you could type in Z or Z,A if you want to see the alpha along with it.

It is also possible to add channels to incoming images using Channel Remapping. If you specify channel names that do not exist in the image file, new channels will be created. This is especially useful if you need to add an alpha channel to a three channel RGB image to increase playback performance[<sup>8</sup>](#footnote_8).

Channel Remapping is controlled by the ChannelMap node. The names of the channels and their order is stored in the **format.channels** property. Channel Remapping occurs when the image data in the file is converted into one of the internal image formats.

Note that there is overlapping functionality between Channel Remapping and Channel Reordering and Channel Isolation, which are described below. However, Channel Remapping occurs just after pixels are read from a file. Channel Reordering and Isolation occur just before the pixel is displayed and typically happen in hardware. Channel Remapping always occurs in software.

## Crop and Uncrop

Cropping an image discards pixels outside of the crop region. The image size is reduced in the process. This can be beneficial when loading a large number of cached images where only a small portion of the frame is interesting or useful (e.g. a rendered element). For some formats, RV may be able to reduce I/O bandwidth by reading and decoding pixels only within the crop region.

<center>![Cropping Parameters. Note that (x1, y1) are coordinates.](../../../../images/rv/crop.png)</center>

<center>*Cropping Parameters. Note that (x1, y1) are coordinates.*</center>

Note that the four crop parameters describe the bottom and top corners not the origin, width, and height. So a “crop” of the entire image would be (0, 0) to (*w* − 1, *h* − 1) where *w* is the image width and *h* is the image height.

Uncropping (in terms of RV) creates a virtual image which is typically larger than the input image [<sup>9</sup>](#footnote_9). The input image is usually placed completely inside of the larger virtual image.

<center>![Uncrop Parameters](../../../../images/rv/uncrop_basic.png)</center>

<center>*Uncrop Parameters*</center>

It is also possible to uncrop an image to a smaller size (in which case some pixels are beyond the virtual image border) or partially in and out of the virtual uncrop image. This handles both the cases of a cropped render and an a render of pixels beyond the final frame for compositing slop.

The OpenEXR format includes a display and data window. These are almost directly translated to uncrop parameters except that in RV the display window always has an origin of (0, 0). When RV encounters differing display and data window attributes in an EXR file it will automatically convert these to uncrop values. This means that a sequence of EXR frames may have unique uncrop values for each frame.

Currently EXR is the only format that supports per-frame uncrop in RV.

<center>![Uncrop of Oversized Render](../../../../images/rv/uncrop_over_render.png)</center>

<center>*Uncrop of Oversized Render*</center>

RV considers the uncropped image geometry as the principle image geometry. Values reported relating to the width and height in the user interface will usually refer to the uncropped geometry. Wipes, mattes, and other user interface will be drawing relative to the uncropped geometry.

## Conversion to Linear Color Space

If an image format stores pixel values in a color space which is non-linear, the values should be converted to linear before any color correction or display correction is applied. In the ICC and EXR documentation, linear space is also called *Scene Referred Space.* The most important characteristic of scene referred space is that doubling a value results in twice the luminance.

Although any image format can potentially hold pixel data in a non-linear color space, there are few formats which are designed to do so. Kodak Cineon files, for example, store values in a logarithmic color space. [<sup>10</sup>](#footnote_10) JPEG images may be stored in “video” space [<sup>11</sup>](#footnote_11) which typically has a 2.2 gamma applied to the color values for better viewing on computer monitors. EXR files on the other hand are typically stored in linear space so no conversion need be applied.

If values are not in linear space, color correction and display correction transforms can still be applied, but the results will not be correct and in some cases will be misleading. So it’s important to realize what color space an image is in and to tell RV to linearize it.

### Non-Rec. 709 Primaries

If an image has attributes which provide primaries, RV will use this information to transform the color to the standard REC 709 primaries RGB space automatically. When the white points do not differ, this is done by concatenating two matrices: a transform to CIE XYZ space followed by a transform to RGB<sub>709</sub> space. When the white points differ chromatic adaptation is used.

### Y RY BY Conversion

OpenEXR files can be in stored as Y RY BY channels. The EXR reader will pass these files to RV as planar images (three separate images instead of one image with three channels). RV will then recombine the images in hardware into RGBA.

This is advantageous when one or more of the original image planes are *subsampled*. Subsampled image planes have a reduced resolution. Typically the chroma channels (in this case RY and BY) are subsampled.

### YUV (YCbCr) Conversion

Some formats may produce YUV or YUVA images to be displayed. RV can decode these in hardware for better performance. RV uses the following matrix to transform YUV to RGB:

![Matrix](../../../../images/rv/math1.png)

where

```
​0 ≤ Y ≤ 1

−0.5 ≤ U ≤ 0.5

−0.5 ≤ V ≤ 0.5
```

In the case of Photo-JPEG, the YUV data coming from a movie file is assumed to use the full gamut for the given number of bits. For example, an eight bit per channel image would have luminance values of [0, 255]. For Motion-JPEG a reduced color gamut is assumed.

On hardware that cannot support hardware conversion, RV will convert the image in software. You can tell which method RV is using by looking at the image info. If the display channels are YUVA the image is being decoded in hardware [<sup>12</sup>](#footnote_12). On Linux, this option must be specified when RV is started using the -yuv flag. [<sup>13</sup>](#footnote_13)

### Log to Linear Color Space Conversion

When RV reads a 10 bit Cineon or DPX file, it converts 10 bit integer pixel values into 16 bit integer values which are typically in a logarithmic color space. In order to correctly view one of these images, it is necessary to transform the 16 bit values into linear space. RV has two transforms for this conversion. You can access the function via the Color menu from the menu bar. For standard Cineon/DPX RV uses the default Kodak conversion parameters [<sup>14</sup>](#fn14). Alternately, if the image was created with a Grass Valley Viper FilmStream camera, you should use the Viper log conversion.

The Kodak Log conversion can produce values in range [0, ~13.5]. To see values outside of [0,1] use the exposure feature to stop down image. A value of -3.72 for relative exposure will show all possible output values of the Kodak log to linear conversion.

### ARRI LogC to Linear Color Space Conversion

When viewing ARRI raw images, RV will use the header values to supply LogC parameters. In cases where no information is available (e.g., a DPX file encoded with LogC) the parameters for an 800 ASA exposure index will be used if no other information is available.

### File Gamma Correction

If the image is stored in “video” or “gamma” space, you can convert to linear by applying a gamma correction. RV has three gamma transforms: one for linearization, one for display correction, and one in the middle for color correction. The gamma color correction can be activated via the Color→File Gamma menu items. When an image is stored in gamma space, it typically is transformed by the formula ![equation](../../../../images/rv/math2.png) where ![gamma](../../../../images/rv/gamma.png) is the gamma value and *c* is the channel value. When transforming back to linear space it’s necessary to apply the inverse (*c*<sup>![gamma](../../../../images/rv/gamma.png)</sup>). RV’s file gamma applies *c*<sup>![gamma](../../../../images/rv/gamma.png)</sup>while the color correction gamma and the display gamma apply ![equation](../../../../images/rv/math2.png) (in all cases ![gamma](../../../../images/rv/gamma.png) refers to the value visible in the interface).

### sRGB to Linear Color Space Conversion

If an image or movie file was encoded in sRGB space with the intention of making it easy to view with non-color aware software, RV can convert it to linear on the fly using this transform. In addition, some file LUTs are created to transform imagery from file space to sRGB space directly. If you apply one of these LUTs to an incoming image as a file LUT in RV you can then using the sRGB to linear function to linearize the output pixels.

The sRGB to linear function can be activated via Color→sRGB and is stored per-source like the file gamma above or log to linear.

RV uses the following equation to go from sRGB space to linear:

![equation](../../../../images/rv/math3.png)
where

*p* = 0.04045

*a* = 0.055

### Rec. 709 Transfer to Linear Color Space Conversion

Similar to sRGB, The Rec. 709 non-linear transfer function is a gamma-like transform. High definition television imagery is often encoded using this color space. In order to view it properly on a computer monitor, it should be converted to linear and then to sRGB for display. The Rec. 709 to linear function can be activated via Color→Rec709 and is stored per-source like the file gamma, sRGB, or log to linear.

RV uses the following equation to go from Rec. 709 space to linear:

![equation](../../../../images/rv/math4.png)
where

*p* = 0.081

### Pre-Cache and File LUTs

RV has four points in its pixel pipeline where LUTs may be used. The first of these is the pre-cache LUT. The pre-cache LUT is applied in software, and as the name implies, the results go into the cache. The primary use of the pre-cache LUT is to convert the image colorspace in conjunction with a bit depth reformatting to maximize cache use.

The file LUT and all subsequent LUTs are applied in hardware and are intended to be used as a conversion to the color working space (usually some linear space). However, the file LUT can also be used for as a transform from file to display color space if desired.

See Chapter [Using LUTs in RV](using-luts-in-rv.html) for more information about how LUTs work in RV.

### File CDLs

In much the same way you can assign a File LUT to help linearize a file source into the working space in RV you can also use a file CDL. This CDL is applied before linearization occurs. There is also a look slot for CDL information described later.

See Chapter [Using CDLs in RV](using-cdls-in-rv.html) for more information about how LUTs work in RV.

## Color Correction

None of the color corrections affects the Alpha channel. For a good discussion on linear color corrections, check out Paul Haeberli’s Graphica Obscura website [Graphica Obscura](http://www.graficaobscura.com/).

Color corrections are applied independently to each image source in an RV session. For example, if you have two movies playing in sequence in a session and you change the contrast, it will only affect the movie that is visible when the contrast is changed. (If you want to apply the same color correction to all sources, perform the correction in tiled mode: Tools→Stack, Tools→Tile.)

### Luminance LUTs

After conversion to linear, pixels may be passed though a luminance look up table. This can be useful when examining depth images or shadow maps. RV has a few predefined luminance LUTs: HSV, Random, and a number of contour LUTs. Each of these maps a luminance value to a color.

### Relative Exposure

RV’s computes relative exposure like this:

*c* × 2<sup>*exposure*</sup>

The c is the incoming color. So a relative exposure of -1.0 will cause the color to be divided by 2.0.

Relative exposure can alternately be thought of as increasing or decreasing the stop on a camera. So a relative exposure of -1.0 is equivalent to viewing the image as if the camera was stopped down by 1 when the picture was taken.

To map an exact range of values (where 0 is always the low value) set the exposure to ![equation](../../../../images/rv/math5.png) where *max* is the upper bound.

### Hue Rotation

The unit of hue rotation is radians. RV’s hue rotation is luminance preserving. A hue rotation of 2π will result in no hue change.

The algorithm is as follows:

* Apply a rotation that maps the grey vector to the blue axis.
* Compute the vector *L* that is perpendicular to the plane of constant luminance.
* Apply a skew transform to map the vector *L* onto the blue axis.
* Apply a rotation about the blue axis *N* radians where *N* is the amount of hue change.
* Apply a rotation that maps the blue axis back to the grey vector.

RV computes luminance using this formula [<sup>15</sup>](#footnote_15):

![equation](../../../../images/rv/math6.png)

where [<sup>16</sup>](#footnote_16)

*R*<sub>*w*</sub> = 0.3086

*G*<sub>*w*</sub> = 0.6094

*B*<sub>*w*</sub> = 0.0820

### Relative Saturation

RV applies the formula:

![equation](../../../../images/rv/math7.png)

where

*R*<sub>*w*</sub> = 0.3086

*G*<sub>*w*</sub> = 0.6094

*B*<sub>*w*</sub> = 0.0820

and *s* is the saturation value.

### Contrast

RV applies the formula:

![equation](../../../../images/rv/math8.png)

where *k* is the contrast value.

### Inversion

RV applies the formula:

![equation](../../../../images/rv/math9.png)

### ASC Color Decision List (CDL) Controls

ASC-CDL controls are as follows:

*SOP* = *Clamp (C*<sub>*in*</sub> *&#42;* *slope* + *offset*)<sup>*power*</sup>

where *slope*, *offset*, and *power* are per-channel parameters

The CDL saturation is then applied to the result like so:

![equation](../../../../images/rv/math10.png)

where

*R*<sub>*w*</sub> = 0.2126

*G*<sub>*w*</sub> = 0.7152

*B*<sub>*w*</sub> = 0.0722

and *s* is the saturation when *s* ≥ 0

## Display Simulation and Correction

After color corrections have been applied in linear space and before pixels are sent to the display device, they undergo display transformations. These transforms are intended to simulate the appearance of pixels on alternate display devices (like film) and to correct for any color transform that will be applied by the primary display device. In addition, RV provides a few tools to help visualize image pixel values in various ways.

Unlike color corrections, display color corrections apply to all source material in an RV session.

### Display and Look LUTs

There are times when it’s necessary to have two separate display LUTs—one which might be per-shot and one which is global. For example, this can happen when digital intermediate color work is being done on plates while the un-corrected plates are being worked on; a temporary LUT may be needed to simulate the “look” of the final result.

There is a unique look LUT per source. There is a single display LUT for an RV session.

RV applies the look LUT just before the display LUT.

See Chapter [Using LUTs in RV](using-luts-in-rv.html) for a more detailed explanation of usage and how to load a LUT into RV.

### Display Gamma Correction

This gamma correction is intended to compensate for monitor gamma. It is not related to File Gamma Correction.

For a given monitor, there is usually one good value (e.g., 2.2) which when applied corrects the monitor’s response to be nearly linear. Note that you should not use the Display Gamma Correction if your monitor has been calibrated with a gamma correction built in.

If you are using the X Window System (Linux/Unix) or Microsoft Windows, the default is not to add a gamma correction for the monitor.

On X Windows, this can be checked using the xgamma command. For example, in a shell if you type:

```
shell> xgamma
```

and you see:

```
-> Red 1.000, Green 1.000, Blue 1.000
```

Then your display has no gamma correction being applied. In this case you will want RV to correct for the non-linear response by setting the Display Gamma to correct for the monitor (e.g., 2.2).

On Mac OS X, things are more complex. Typically, a ColorSync profile is created for your monitor and this includes a gamma correction. However, the monitor may be corrected to achieve a non-linear response. The best bet on OS X is to calibrate the display in such a way that a linear response is achieved and don’t use a Display Gamma other than 1.0 in RV.

The Display Gamma can be set from the View menu.

### sRGB Display Correction

Most recently made monitors are built to have an sRGB response curve. This is similar to a Gamma 2.2 response curve, but with a more linear function in the blacks. RV supports this function directly for both input and output without the need to use a LUT. The sRGB display is a better default for most monitors than the display gamma correction above.

RV’s default rules for color set up use the sRGB display. RV also assumes by default that QuickTime movies and JPEG files are in sRGB color space unless they specifically indicate otherwise. This behavior can be overridden (see the Reference Manual).

RV uses the following formula to convert from linear to sRGB:

![equation](../../../../images/rv/math11.png)

where

*q* = 0.0031308

*a* = 0.055

The sRGB Display Correction can be set from the View menu.

### Rec. 709 Non-Linear Transfer Display Correction

If the display device is an HD television or reference monitor it may be naturally calibrated to the Rec. 709 color space. Similar to sRGB, Rec. 709 is a gamma-like curve. RV uses the following formula to convert from linear to Rec. 709:

![equation](../../../../images/rv/math12.png)

where

*q* = 0.018

### Display Brightness

There is a final multiplier on the color which can be made after the display gamma. This is analogous to relative exposure discussed above. The Display Brightness will never affect the hue of displayed pixels, but can be used to increase or decrease the final brightness of the pixel.

This is most useful when a display LUT is being used to simulate an alternate display device (like projected film). In some cases, the display LUT may scale luminance of the image down in order to represent the entire dynamic range of the display device. In order to examine dark parts of the frame, you can adjust the display brightness without worrying about any chromatic changes to the image. Note that bright colors may become clipped in the process.

The Display Brightness can be set from the View menu.

## Final Display Filters

These operations occur after the display correction has been applied and before the pixel is displayed. Unlike color corrections, there is only a single instance of each of these for an RV session. So if you isolate the red channel for example, it will be isolated for all source material.

### Channel Reorder

If you have RGBA or fewer channels read into RV and you need to rearrange them for some reason, you can do so without using the general remapping technique described above. In that case you can use channel reordering which makes it possible to reorder RGBA channels and set one or more of the channels to 0.0 or 1.0\. Channel Reordering can be accessed in the menu bar under View→Channel Order. On supported machines, this function is implemented in hardware (so it’s very fast).

This function can be useful if the image comes from a format with unnamed RGB channels which are not in order. Another useful feature of Channel reordering is the ability to flood one or more channels with the constant value of 1.0 or 0.0\. For example to see the red channel as red without green and blue you could set the order to R000 (R followed by three zeros). To see the red channel as a grey scale image you could use the order RRR0. (Yes, that is exactly what channel isolation does! See below.)

Channel reordering is controlled by the Display node. The **display.channelOrder** attribute determines the order. Channel reordering occurs when the internal image is rendered to the display.

### Isolating Channels

Finally, you can isolate the view to any single channel using the interface from the menu View→Channel Display. Since this is the most common operation when viewing channels, it is mapped to the keys “r”, “g”, “b”and “a” by default (shows isolated red, green, blue, and alpha) and can be reset with the “c” key (show all color channels). You can also view luminance as a pseudo-channel with the “l” key.

Channel isolation is controlled by the Display node. The **display.channelFlood** property controls which channel (or luminance) is displayed. Channel isolation occurs when the internal image is rendered to the display.

### Out-of-range Display

The Out-of-Range color transform operates per channel. If channel data is 0.0 or less, the channel value is clamped to 0.0\. If the channel data is greater than 1.0, the channel data is clamped to 1.0\. If the channel data is in the range [0.0, 1.0] the data is clamped to 0.5.

The idea behind the transform is to display colors that are potentially problematic. If the pixels are grey, then they are “safe” in the [0.0, 1.0] range. If they are brightly colored or dark, they are out-of-range.

0.0 is usually considered an out-of-range color for computer graphics applications when the image is intended for final output.

Some compositing programs have trouble dealing with negative values.

Note that HDR images will definitely display non-grey (bright) pixels when the out-of-range transform is applied. However, they probably should not display dark pixels.

You can turn on Out-of-range Display from the View menu.

<sup>8</sup> <a name="footnote_8"></a> New channels currently inherit the channel data from the first channel in the image. If the data needs to be 1.0 or 0.0 in the new channel, use Channel Reorder to insert constant data.

<sup>9</sup> <a name="footnote_9"></a> Quicktime calls this same functionality “clean aperture.” The OpenEXR documentation refers to something similar as the data and display windows.

<sup>10</sup> <a name="footnote_10"></a> The values in Cineon files are more complex than stated here. Color channel values are stored as code values which correspond to *printing density*–not luminance – as is the case with most other image file formats. Furthermore, the conversion to linear printing density is parameterized and these parameters can vary depending on the needs of the user. See the Kodak documentation on the Cineon format for a more detail description.

<sup>11</sup> <a name="footnote_11"></a> This could mean NTSC color space or something else!

<sup>12</sup> <a name="footnote_12"></a> Conversion of YUVA to RGBA in hardware is an optimization that can result in faster playback on some platforms.

<sup>13</sup> <a name="footnote_13"></a> Note that the color inspector will convert these values to normalized RGBA.

<sup>14</sup> <a name="footnote_14"></a> For Shake users, RV produces the same result as the default parameters for the LogLin node.

<sup>15</sup> <a name="footnote_15"></a> This is also the formula used for luminance display.

<sup>16</sup> <a name="footnote_16"></a> Weight values for R, G, and B are applicable in linear color space. Values used for determining luminance for NTSC video are not applicable in linear color space.
