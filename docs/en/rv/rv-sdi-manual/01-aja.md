---
layout: default
title: AJA
permalink: /rv/rv-sdi-manual/01-aja/
lang: en
---

# AJA

RVSDI will drive a number of AJA products but not all features are available with all hardware. RVSDI can use the AJA drivers on Mac OS X (with the Kona3G or thunderbolt devices), Linux (Kona3G, Kona4), and Windows 7 (Kona3G, Kona4, and thunderbolt devices). Other AJA cards may also work on each of the platforms.

For use with NVIDIA GPUs you will need GPUDirect capable quadro (P6000, P5000, M6000, M5000, M4000, K6000, K5000, 4000, 5000, 6000). Some older quadros or consumer GeForce cards may also work with the AJA hardware, but we do not guarantee any kind of performance with non-quadro kepler or fermi cards. Note that the k4000 is not recommend since it lacks dual copy engines. RVSDI can use both the NVIDIA dual copy engine and DVP/GPUDirect only on professional fermi and kepler quadros.

On Mac OS X RVSDI can drive the Io4K Plus, Io4K, IO XT, and T-Tap thunderbolt devices using either AMD or NVIDIA GPUs.

For Windows and Mac Appropriate AJA drivers can be obtained from the AJA website and installed on any system that RVSDI will run on. For Linux drivers must be compiled or obtained from AJA.

To obtaining driver source code for linux requires enrollment in AJA’s developer program. At that point you can download the driver source code, utility programs, and up-to-date firmware for various hardware.

## Tested Hardware

There are a lot of possible hardware configurations + OSes for AJA playback. In general we recommend the Kona3G or Kona4 for non-thunderbolt use and the Io4K Plus, Io4K or IO XT for thunderbolt machines.

We do **not** recommend using the T-Tap for RVSDI playback: it is possible that we had a damaged test device or RVSDI does something the T-Tap doesn’t like, but we were unable to get steady 1080p@24 HD play back out of the T-Tap. If you’re not concerned with stable play back speeds the T-Tap is fine. It will output the correct color and image.

Here are the ones we’ve tested:

### 2014 Apple Mac Pro (Trash Can)

We tested 4K AJA playback with the Io4K Plus, Io4K, 2K and stereo 2K with IO XT, and HD mono with the T-Tap. Images were stored on the built in SSD. We were able to use all of the Io4K and IO XT modes. RVSDI was not able to drive the T-Tap for 1080p@24 and we’ve never figured out why.

The Io4K HDMI output was also verified.

### Apple MacBook Pros with Nvidia GPUs (thunderbolt 2)

RVSDI cannot drive SDI or HDMI even at HD resolutions on these machines because of the poor GPU read back performance. Do not use Apple Macs with Nvidia GPUs with RVSDI if you’re concerned about stable playback.

### Apple MacBook Pros with ATI/AMD GPUs (thunderbolt 1)

We have successfully used the IO XT (which is thunderbolt v1) with Mid 2011 MacBook Pros.

### Apple Mac Pro Towers

We have not tested the older Mac Pro Tower machines with AJA products. We have had reports that they work for 2K Kona3G and IO XT output. So far no reports with Kona3G in 4K mode or Kona4.

### HP z800 Linux and Windows (PCIe 2)

For Linux and Windows SDI testing we have an HP z800 workstation. In order to use this machine you must put the AJA Kona3G into slot &#35;4 and the GPU in slot &#35;2. The GPU should be GPUDirect capable quadro. These GPUs have “dual copy engines” which RVSDI can use to facilitate fast I/O to and from the Nvidia card. If you plan on using 4K output please avoid using the k4000/k4200; these GPUs have only a single “copy engine”.

Linux ubuntu 10.04, Centos 6.2, and Windows 7.

### HP z820 Linux and Windows (PCIe 3)

We also have a z820 for SDI testing. This machine requires use of slot 6 for the Kona3G/Kona4 card and slot 2 for the GPU. The GPU should be a GPUDirect capable quadro. These GPUs have “dual copy engines” which RVSDI can use to facilitate fast I/O to and from the Nvidia card. If you plan on using 4K output please avoid using the k4000/k4200; these GPUs have only a single “copy engine”.

If you have a choice between a z800 and z820 choose the z820 especially of you will be using a Kona 4.

Linux ubuntu 10.04, Centos 6.2, and Windows 7.

## The “AJA” and “AJA (Control Panel)” SDI Modules

RVSDI has two different Video Modules both which can operate the AJA hardware. The “AJA” module operates like the NVIDIA SDI module; it allows you to set all aspects of the video and data output formats as well as set up stereo output and ancillary HDMI output.

The “AJA (Control Panel)” module does not set up the hardware formats itself, but will use the current settings from the AJA control panel and/or cables program. This makes it possible to set up unique routing on the AJA card. This module is currently unable to produce stereo output but is planned for a future release.

## DCI 2K, 4K, and UHD 4K Output

AJA products may support mono and stereo DCI 2K (2048 x 1080) and in the case of the Kona 3G with appropriate firmware installed quad DCI 4K (4096 x 2160) and quad UHD 4K (3840 x 2160).

Not all formats are available on all platforms and devices.

Starting with AJA SDK 14, 4K/UHD SDI output can use two different modes:

1. quadrant mode : the image is split into 4 quadrants, one quadrant per cable; the receiving device will then combine these four quandrants into a single image. This is the “traditional” way of outputting 4K and the mode rvsdi used before SDK 14;
2. two-sample-interleave (aka 2SI aka TSI) mode: the image is split into 4 HD-resolution images, one image per cable; the receiving device, if it supports 2SI, can then combine these four images into a full 4K-resolution image. Note that each cable then provides a valid HD image that can be fed to non-2SI equipment (the HD image is formed by taking one out of every four pixels of the original 4K image, therefore the result is not as good as if going through a more elaborate downconverter).

This also affects HDMI: in quadrant-mode, HDMI will be downconverted to HD by the AJA board; in two-sample-interleave mode, HDMI will be a proper full-resolution 4K image. This is a limitation imposed by the AJA board.

To select Quadrant vs Two-sample-interleave mode, use the “4K Transport” drop-down menu in the Video preferences.

Note that this only affects 4K/UHD resolutions.

## High Frame Rate (HFR) DCI 2K and 4K at 60hz and 48hz

With recent firmware and drivers (late 2014) its possible to run the Kona3G using RVSDI with mono or stereo DCI 2K 60hz. The Kona4 additionally supports mono and stereo DCI 2K and 4K at 48hz and 60hz.

## AJA Specific Configuration Options

There are additional options which can be passed to the AJA device via environment variables or from the preferences Additional Options field.

The preferences field takes command line-like syntax:

```
AJA NTV2 Device Options:
  -h [ --help ]                      Usage
  -v [ --verbose ]                   Verbose
  --rec601                           Use Rec.601 Color Matrix (default is
                                     Rec.709)
  -p [ --profile ]                   Output Debugging Profile
                                     (twk_aja_profile_<ID>.dat)
  -m [ --method ] arg                Method (dvp, sdvp, ipbo, ppbo, basic, p2p)
  --flip                             Flip Image Orientation
  -s [ --ring-buffer-size ] arg (=4) Ring Buffer Size
  -n [ --no-aquire ]                 Do not attempt to aquire device from AJA
                                     control panel
  -a [ --level-a ]				   Enable Level A timing when possible.
```

So for example the following forces the use of Rec.601 color conversion matrix and a ring buffer size of 4:

```
--rec601 --ring-buffer-size 4
```

It is possible to use environment variables instead which correspond to the command options above:

```
TWK_AJA_HELP
TWK_AJA_VERBOSE
TWK_AJA_REC601_MATRIX
TWK_AJA_PROFILE
TWK_AJA_METHOD <method>
TWK_AJA_FLIP
TWK_AJA_RING_BUFFER_SIZE <size>
TWK_AJA_NO_AQUIRE
TWK_AJA_LEVEL_A
```

In the case of TWK_AJA_METHOD and TWK_AJA_RING_BUFFER_SIZE the value of the environment variable determines the argument. In the other cases the presence of the environment determines the value (i.e. if TWK_AJA_VERBOSE is not set there will not be verbose output).

### Method

Normally, the best possible method given the hardware and OS will be used. However, you can override this behavior using the method argument with one of these values:

| Method | Description |
|-|-|
| dvp | Use NVIDIA DVP when available (default on Windows) |
| sdvp | Use NVIDIA DVP without overlapping DMA (useful for profiling only) |
| ipbo | Use immediate copy OpenGL PBOs for read back |
| ppbo | Use shared pointer OpenGL PBOs for read back (mac only) |
| basic | Use simplest possible GL read back scheme (not recommended) |
| p2p | Use SDI-Link (AMD firepro only) |

### Ring Buffer Size

There is a minimum and maximum ring buffer size for a given hardware setup. The lowest possible value is 2, but in practice 3 or 4 is usually required. The maximum value is 4 to 6 depending on the format begin used. For example 10 bit DCI 2K stereo requires extra memory limiting the ring buffer size to a maximum of 4. The ring buffer size should be set to the lowest possible value in order to reduce latency.

When the size is set too small, play back will be slow and stutter.

## HDMI Output

RVSDI will hook up HDMI output on devices that have HDMI to mimic the SDI settings. In most cases you should be able to hook the output up to an HDMI capable device and get the same output that SDI is providing. On the Io4K Plus, Io4K and Kona4 the HDMI output will be the same resolution as the SDI output including UHD and DCI 4K. For devices which cannot do 4K HDMI the HDMI will have a downconverted image where available.

In stereo modes HDMI is currently set up to show the first eye.

## AJA Device Firmware (enabling 4K on the Kona3G)

The standard Kona3G firmware is not able to output 4K formats. In order to enable 4K “Quad” firmware must be loaded onto the Kona card. This converts the card into either four inputs or four outputs but no mixed inputs and outputs (like the standard firmware can do).

RVSDI only ever uses the Kona3G for output. When the Quad firmware is detected, RVSDI will enable 4K output in the Video preferences for the Kona device. The usual HD and DCI 2K formats are still available with the Quad firmware installed.

The Kona4 and Io4K support 4K with their standard firmware.

## Rendering and Hardware Configuration

Throughput from main memory to the GPU, back to main memory, and finally to the AJA hardware requires fine tuning of RVSDI’s rendering options. There are a number of requirements that need to be met in order to obtain best results:

Most importantly, when using a Kona3G/Kona 4 card in a PCIe2 or PCIe3 slot, make sure that the GPU and the Kona card reside in slots which have different controllers. For example in an HP z800 or z820 workstation the GPU is frequently used in slot &#35;2. By putting the Kona card in slot &#35;4 which is not serviced by the same controller maximum bandwidth between the two cards can be achieved. AJA’s website has a page describing recommend configurations for various hardware:

* [KONA PC Configuration](https://www.aja.com/en/support/kona-pc-system-configuration)
* [KONA Mac Configuration](https://www.aja.com/en/support/kona-system-configuration)

### NVIDIA Fermi and Kepler Quadros (Windows and Linux)

Supported Quadros with a propertly installed Kona3G on a fast machine (z800) is currently the only option for DCI and UHD 4K output.

NVIDIA fermi and kepler quadro GPUs allow the use of GPUDirect (called DVP in video applications) to transfer data between the GPU and an external video card like the Kona on Windows and Linux. RVSDI can use DVP to parallelize IO between the two cards and main memory. This can result in a huge performance win if set up properly.

However, in order to fully utilize the bandwidth to and from the GPU multithreaded upload, prefetch, and PBOs must be enabled in RVSDI’s render preferences when the GPU has dual copy engines. Fermi 4000 and 6000 Quadros and Kepler 5000 and 6000 Quadros all have dual copy engines. The Kepler 4000 has only a single copy engine so using multithreaded upload is not a good idea on that card when using DVP.

In addition vertical sync (v-sync) must be enabled in the NVIDIA driver and disabled in RVSDI on Linux.

### AMD FirePro on Windows

RVSDI can use SDI-Link to speed up communication between AMD FirePro GPUs and the Kona3G. Special “GMA” firmware is required for the Kona3G to use SDI-Link.

### Geforce and Low end Quadro NVIDIA cards (Windows and Linux)

Geforce and lower end Quadro cards without dual copy engines are not supported for AJA SDI output on Windows and Linux. However, these may work using non-DVP methods (ipbo method). GPUs with one copy engine (k4000) are preferable to those with none.

With these GPUs try multithreaded upload, PBOs, and prefetch on in the Render preferences. If the results are not good try turning off multithreaded uploads.

In some cases you may get a GPU to work by increasing the size of the ring buffer. The maximum size for HD formats is 6.

### NVIDIA Kepler GPUs on Apple Computers

On Apple computers PBOs with prefetch are also recommended, but multithreaded upload may or may not be helpful. Alternately, using Apple Client Storage (also in the Render tab of the preferences) instead of PBOs may be more beneficial with some GPUs.

RVSDI will use a specialized asynchronous read back scheme on Apple computers (corresponding to the “ppbo” method).

Thunderbolt AJA devices are supported along with Kona 3G in older Mac Pro desktop machines.

### AMD GPUs on Apple Computers

On Apple machines with AMD GPU always use Apple Client Storage (with prefetch) instead of PBOs.

RVSDI will use a specialized asynchronous read back scheme on Apple computers (corresponding to the “ppbo” method).

Thunderbolt AJA devices are supported along with Kona 3G in older Mac Pro desktop machines.

### Intel Graphics on Apple Computers

The Intel 4000 or earlier integrated graphics GPUs are unlikely to work with RVSDI and are not supported.
