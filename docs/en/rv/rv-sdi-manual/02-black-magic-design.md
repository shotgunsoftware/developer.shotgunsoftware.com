---
layout: default
title: Blackmagic Design
permalink: /rv/rv-sdi-manual/02-black-magic-design/
lang: en
---

# Blackmagic Design

RVSDI can output to Blackmagic Design devices which use the DeckLink API. This includes the DeckLink capture and playback cards and thunderbolt UltraStudio devices. Although it may work with other devices like the UltraStudio for USB 3.0 they have not yet been tested.

RVSDI can drive stereo SDI and HDMI when available.

## Tested Hardware

We have tested only two Blackmagic devices: an UltraStudio Mini Monitor and a PCIe DeckLink Extreme cards. There are a lot of possible hardware configurations + OSes for Blackmagic playback. We have only test some very specific configurations, but have had reports of success from most users.

Here are the ones we’ve tested:

### 2014 Apple Mac Pro (Trash Can)

We tested the UltraStudio Mini Mintor successfully on the Mac Pro Trash Can. We have not yet tested the UltraStudio 4K with thunderbolt 2 output but have had reports that it works.

### Apple MacBook Pro with Nvidia GPUs (thunderbolt 2)

RVSDI cannot drive SDI or HDMI even at HD resolutions on these machines because of the poor GPU read back performance. Do not use Apple Macs with Nvidia GPUs with RVSDI if you’re concerned about stable playback. The best we’ve been able to achieve with these machines is UltraStudio Mini Monitor output.

### Apple MacBook Pros with ATI/AMD GPUs (thunderbolt 1)

We have successfully used the UltraStudio Mini Monitor with these machines. We would expect other DeckLink thunderbolt 1 devices to operate as well.

### HP z800 Linux and Windows (PCIe 2)

For Linux and Windows SDI testing we have an HP z800 workstation. In order to use this machine you must put the BM DeckLink card into slot &#35;4 and the GPU in slot &#35;2. The GPU should be a k5000, k6000, or fermi 6000 or 4000 quadro. For 6G output the k4000 may also work well.

Linux ubuntu 10.04 and Windows 7.

### HP z820 Linux and Windows (PCIe 3)

We also have a z820 for SDI testing. This machine requires use of slot 6 for the DeckLink card and slot 2 for the GPU. The GPU should be a k5000, k6000, or fermi 6000 or 4000 quadro. For 6G output the k4000 may also work well.

Linux ubuntu 10.04 and Windows 7.

## DCI 2K, 4K, and UHD 4K Output

Blackmagic’s DCI 2K and 4K output is supported when available but only on machines capable of sustaining 4K throughput from the GPU to the SDI device.

Not all formats are available on all platforms and devices.

## Blackmagic Specific Configuration Options

There are additional options which can be passed to the AJA device via environment variables or from the preferences Additional Options field.

The preferences field takes command line-like syntax:

```
Blackmagic Device Options:
  -h [ --help ]                      Usage
  -v [ --verbose ]                   Verbose
  -m [ --method ] arg                Method (dvp, ipbo, basic)
  -s [ --ring-buffer-size ] arg (=4) Ring Buffer Size
```

It is possible to use environment variables instead which correspond to the command options above:

```
TWK_BLACKMAGIC_HELP
TWK_BLACKMAGIC_VERBOSE
TWK_BLACKMAGIC_METHOD <method>
TWK_BLACKMAGIC_RING_BUFFER_SIZE <size>
```

In the case of TWK_BLACKMAGIC_METHOD and TWK_BLACKMAGIC_RING_BUFFER_SIZE the value of the environment variable determines the argument. In the other cases the presence of the environment determines the value (i.e. if TWK_BKACKMAGIC_VERBOSE is not set there will not be verbose output).

### Method

Normally, the best possible method given the hardware and OS will be used. However, you can override this behavior using the method argument with one of these values:

| Method | Description |
|-|-|
| ipbo | Use immediate copy OpenGL PBOs for read back |
| basic | Use simplest possible GL read back scheme (not recommended) |

### Ring Buffer Size

There is a minimum and maximum ring buffer size for a given hardware setup. The lowest possible value is 2, but in practice 3 or 4 is usually required. The maximum value is 4 to 6 depending on the format begin used. For example 10 bit DCI 2K stereo requires extra memory limiting the ring buffer size to a maximum of 4. The ring buffer size should be set to the lowest possible value in order to reduce latency.

When the size is set too small, play back will be slow and stutter.

## HDMI Output

HDMI output is always enabled for devices which have HDMI.

## Rendering and Hardware Configuration

Throughput from main memory to the GPU, back to main memory, and finally to the Blackmagic hardware requires fine tuning of RVSDI’s rendering options. There are a number of requirements that need to be met in order to obtain best results.

Most importantly, when using a DeckLink card in a PCIe2 or PCIe3 slot, make sure that the GPU and the DeckLink card reside in slots which have different controllers. For example in an HP z800 or z820 workstation the GPU is frequently used in slot #2\. By putting the DeckLink card in slot &#35;4 which is not serviced by the same controller maximum bandwidth between the two cards can be achieved.

### NVIDIA Fermi and Kepler Quadros (Windows and Linux)

Supported Quadros with a properly installed DeckLink on a fast machine (z800) is currently the only option for DCI and UHD 4K output.

NVIDIA fermi and kepler quadro GPUs allow the use of GPUDirect (called DVP in video applications) to transfer data between the GPU and an external video device. RVSDI can use DVP to parallelize IO between the two cards and main memory. This can result in a huge performance win if set up properly.

However, in order to fully utilize the bandwidth to and from the GPU multithreaded upload, prefetch, and PBOs must be enabled in RVSDI’s render preferences when the GPU has dual copy engines. Fermi 4000 and 6000 Quadros and Kepler 5000 and 6000 Quadros all have dual copy engines. The Kepler 4000 has only a single copy engine so using multithreaded upload is not a good idea on that card when using DVP.

In addition vertical sync (v-sync) must be enabled in the NVIDIA driver and disabled in RVSDI on Linux.

### AMD FirePro on Windows

SDI-Link is not yet supported with Blackmagic devices.

### Geforce and Low end Quadro NVIDIA cards (Windows and Linux)

Geforce and lower end Quadro cards without dual copy engines are not supported for Blackmagic SDI output on Windows and Linux. However, these may work using non-DVP methods (ipbo method). GPUs with one copy engine (k4000) are preferable to those with none.

With these GPUs try multithreaded upload, PBOs, and prefetch on in the Render preferences. If the results are not good try turning off multithreaded uploads.

In some cases you may get a GPU to work by increasing the size of the ring buffer. The maximum size for HD formats is 6.

### NVIDIA Kepler GPUs on Apple Computers

On Apple computers PBOs with prefetch are also recommended, but multithreaded upload may or may not be helpful. Alternately, using Apple Client Storage (also in the Render tab of the preferences) instead of PBOs may be more beneficial with some GPUs.

RVSDI will use a specialized asynchronous read back scheme on Apple computers (corresponding to the “ppbo” method).

Thunderbolt UltraStudio devices are supported along with DeckLink cards for older Mac Pro desktop machines.

### AMD GPUs on Apple Computers

On Apple machines with AMD GPU always use Apple Client Storage (with prefetch) instead of PBOs.

RVSDI will use a specialized asynchronous read back scheme on Apple computers (corresponding to the “ppbo” method).

Thunderbolt UltraStudio devices are supported along with DeckLink cards for older Mac Pro desktop machines.

### Intel Graphics on Apple Computers

The Intel 4000 or earlier integrated graphics GPUs are unlikely to work with RVSDI and are not supported.
