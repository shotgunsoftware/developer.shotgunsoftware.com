---
layout: default
title: Configuring the SDI Device
permalink: /rv/rv-sdi-manual/configuring-the-sdi-device/
lang: en
---

# Configuring the SDI Device

In the Video preferences tab choose the AJA/Blackmagic video module. Make sure you understand what data and video formats your output device will accept. In the case of stereo, make sure it can use dual SDI outputs—one for each eye.

The AJA hardware can output progressive, interlaced, and progressive segmented frame (PsF) video formats up to 4096x2160 resolution.

<center>![Video preferences](../../../../images/rv/video_prefs.png)</center>

<center>*Video Preferences Showing NVIDIA-SDI Configuration*</center>

<center>![Latency](../../../../images/rv/latency.png)</center>

<center>*Latency Configuration Panel With a Manually Added External Frame Latency*</center>

| | |
|-|-|
| **Output Module** | This should be set to Blackmagic or AJA. If you don’t see Blackmagic or AJA as an option you may be using the vanilla rv binary or you don't have SDI hardware drivers installed. Make sure you are using rvsdi on a machine with the proper hardware. |
| **Output Device** | In the AJA/Blackmagic case the hardware product name will be displayed for each device detected. |
| **Output Video Format** | The video format determines the resolution, frame rate, and whether or not the video scanlines are sent interlaced or progressive. Most projectors will use either a progressive or progressive segmented frame (PsF) format. |
| **Output Data Format** | The data format indicates how the the pixels are to be presented to the device. This can include the numerical precision as well as color space (e.g. RGB or YCbCr). The current version of RVSDI can output stereo via dual SDI outputs by choosing the Stereo Dual 4:2:2 data format. This is the only stereo SDI format which we currently support. You can still use the typical anaglyph, side-by-side, and similar formats found under the View → Stereo menu; these will work regardless of SDI data format. |
| **Sync Method** | Typically in the scenarios RVSDI is used in this will be set to free running. |
| **Sync Source** | If the synchronization can come from an external device it can be configured here. This option will usually change depending on the sync method. |
| **Use as Presentation Device** | Check this box to make RVSDI use the SDI device for presentation mode. |
| **Output Audio to this Device** | If checked, audio will be packaged as ancillary data in the SDI frames. Otherwise, audio will be output through the selected audio device on the computer. RVSDI currently will output audio data on the first four audio channels. Only a left and right channel is supported and each is duplicated. |
| **Incorporate Video Latency into Audio Offset** | If checked, the total latency as indicated in the Configure Latency dialog box will be applied to the audio offset – but only if audio is being played by the controller instead of the output device (i.e. Output Audio to this Device is not checked). This is especially useful with SDI output because the device can have up to five frames of latency. The buffer size can vary over time so RVSDI can measure and automatically add latency to the computer's audio output to aid in keeping audio synced with video. When outputting the audio in the SDI packets directly (Output Audio to this Device) then this is not an issue. If you have additional SDI devices that also buffer frames connected to the output, you may have incorporate that into the total latency in the Configure Latency dialog box. |

## Issues with Stereo

The SDI device has a single additional stereo mode beyond stereo emulation that rv already has—stereo dual output. This data format outputs the left and right eyes each on its own SDI output.

When using SDI stereo you do not need to set any of the stereo modes under the View→Stereo menu; you should leave this off for most situations.

The View→Stereo→Hardware mode is not only unnecessary, but can be confusing in this situation. That mode is for use only by the controller window—it has no effect on the SDI output. This mode enables Quad-Buffered Stereo which is only available with Quadro cards connected to 120 Hz or faster DVI or DisplayPort monitors.

The other stereo emulation modes (anaglyph, etc) will function with SDI when not using the dual output format. When the dual stereo output format is selected, the stereo emulation modes will output images for each eye. So for example, anaglyph will output a red left eye image and cyan right eye image for each SDI output. Right and left eye only modes will duplicate the eye on each output.
