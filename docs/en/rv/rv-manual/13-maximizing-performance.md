---
layout: default
title: Maximizing Performance
permalink: /rv/rv-manual/13-maximizing-performance/
lang: en
---

# Maximizing Performance

RV is primarily a desktop playback program. As such, there are no guarantees about performance. That being said, there are a number of methods to tune performance for any particular hardware configuration and operating system. The most important parameters to tune for good performance in RV are:

* The number of CPUs/cores available versus the number of reader threads used in RV
* The specific file format being read (not all are created equal) and possible filesystem requirements like striping or guaranteed bandwidth constraints
* The I/O method for each file format (if it has multiple methods) versus the type of mass storage (SAN, RAID, or stripped disks, etc)
* If the file format decoder is threaded, the number of threads used for decoding (and balancing that with the number of reader threads)
* A fast PCI bus and a recent GPU

Most of these settings are available from either the caching preference pane or the rendering preference pane.

<center>![Render Preference Pane](../../../../images/rv/render_prefs.jpg)</center>

<center>*Render Preference Pane*</center>

<center>![Caching Preference Pane](../../../../images/rv/caching_prefs.jpg)</center>

<center>*Caching Preference Pane*</center>

## File I/O and Decoding Latency

When reading frames directly from disk, file I/O is often a huge bottleneck. If your frames live across a network connection (such as an NFS mount) the latency can be even greater. Ideally, if RV is playing frames without caching, those frames would be on a local disk drive, RAID, or SAN sitting on a fast bus.

Part of the I/O process is decoding compressed image formats. If the decoding is compute intensive, the time spent decoding may become a bottleneck. If good playback performance off of disk is a requirement, you should choose a format that does not require extensive decoding (Cineon or DPX) or one that can be parallelized (EXR).

As always, there is a tradeoff between file size and decoding time. If you have a very slow network, you might get better performance by using a format with complex expensive compression. If your computer is connected to a local high-speed RAID array or an SSD, then storing files that are easy to decompress but have larger file size may be better.

### EXR, DPX, JPEG, Cineon, TARGA, and Tiff I/O Methods

The OpenEXR, DPX, JPEG, Cineon, TARGA, and Tiff file readers all allow you to choose between a few different I/O methods. The best method to use depends on the context RV is being used in. The method can be selected either from the command line or from the preferences (under each of the file formats). The command line options -exrIOMethod, -dpxIOMethod, -jpegIOMethod, -cinIOMethod, -tgaIOMethod, and -tiffIOMethod, require a number which corresponds to the methods listed in the table below and an optional I/O chunk size in bytes. Currently only the asynchronous methods use the chunk size.

| Method | Number | Description |
|-|-|-|
| Standard | 0 | Use the standard native I/O method on the platform. On Windows this uses the WIN32 API. On Linux/Mac the standard C++ I/O streams are used. The file may be decoded piecemeal. |
| Buffered | 1 | Use the standard I/O but prefer that the file system cache is used. Attempt to read the file in the largest chunk possible. |
| Unbuffered | 2 | Use the standard I/O but ask the kernel to bypass the file system cache. Attempt to read the file in the largest chunk possible. |
| Memory Mapped | 3 | Memory Map files using the native memory mapping API. |
| Asynchronous Buffered | 4 | Asynchronous I/O using the native API. The chunk size may need to be manually tuned. |
| Asynchronous Unbuffered | 5 | Asynchronous I/O using the native API and bypassing the file system cache. The chunk size may need to be manually tuned. |

<center>*I/O Methods*</center>

On Windows, the default is to use the Asynchronous Unbuffered method; this method generally produces the best results over the network and acceptable performance from a local drive.

Typically, the circumstance in which RV is used will dictate which method is optimal.

When using multiple reader threads, asynchronous methods may not scale as well as the synchronous ones.

### Multiple Reader Threads

When caching to the region or look-ahead cache, multiple threads can be used to read and process the frames. This can have a profound impact on I/O speed for most formats. You can select the number of threads from the command line using or via the preferences under → (requires restarting RV to take effect).

The optimal number of threads to use varies with file format, hardware, and network or storage. However a good rule of thumb is to use the number of cores minus one; this leaves one core to handle I/O overhead and other threads (like audio) which may need to run as well. In some cases using more threads may increase performance and in others it will decrease performance.

The file format used can also have an impact on the number of threads. OpenEXR in particular has its own threaded decoder. It may be necessary to leave some cores free to decode only.

With Quicktime movies, the codec becomes important when using multiple threads. For single frame codecs like Photo-JPEG using many threads is advantageous. For H.264 and similar inter-frame codecs, using a single thread is usually the best bet though internally the writer make create more threads.

If your storage hardware has high latency (for instance network storage vs local disk) you may find that it makes sense to have more reader threads than cores. This is because the high latency means that most reader threads will sit in IO wait states and not compete for CPU cycles. In general, in network storage situations, it makes sense to start with a number of reader threads equal to cores-1 or cores-2 and then increase the number of reader threads until you see a drop in performance. Also note that it is difficult to test this kind of performance, since a modern operating system will cache pages read from the network or disk in a RAM filesystem cache. On Linux, you can clear the page cache by typing the following as root:

```
shell> echo 1 > /proc/sys/vm/drop_caches
```

## Internal Software Operations

Some operations occur in software in RV. For example, when you read images in at a reduced resolution, the image has to be resampled in software. When software operations are being performed on incoming images, it’s a good idea to use caching. If direct from disk playback performance is important than these operations should be avoided:

* Image resolution changes
* Pre-Cache LUT
* Color resolution changes (e.g. float to 8 bit int color)
* Cropping
* Channel remapping

The use of cropping can either increase or decrease performance depending on the circumstances.

## RAM

The fastest playback occurs when frames are cached in your computer’s RAM. The more RAM you have, the more frames that RV can cache and the more interactive it becomes. By default RV will load images at their full bit depth and size. E.g., a 32 bit RGBA tiff will be loaded, cached and sent to the graphic card at full resolution and bit depth. This gives artists the ability to inspect images with access to the full range of color information and dynamic range they contain, and makes it possible to work with high-dynamic range imagery.

However, for playback and review of sequences at speed users may wish to cache images with different settings so as to fit more frames into the available RAM. You increase the number of frames that will fit in the cache by having RV read the frames with reduced resolution. For example, reducing resolution by half can result in as many as four times the number of frames being cached.

Similarly, reducing the color resolution can squeeze more frames into memory. For example a 1024x1024 4 channel 8-bit integer image requires 4Mb of memory internally while the same image as 16-bit floating point requires 8Mb and a 32-bit float image requires 16Mb. So by having RV reduce a 32-bit float image to an 8-bit image, you can pack four times the number of frames into memory without changing the image size.

Not caching the Alpha channel of a 4 channel image will also reduce the memory footprint of the frames. You can tell RV to remap the image channels to R, G, B before caching. This may affect playback speed for other reasons, depending on your graphics card. You will need to experiment to determine if this works well on your system.

### Pixel Buffer Objects (PBOs) and Prefetch

RV has an optional method of uploading pixels to the graphics card (PBOs). Normally, this is the fast path for maximum bandwidth to the card. However, some combinations of driver and GPU may result in poor performance. You can turn off the use of PBOs in the preferences or from the command line if you suspect PBOs are causing a bottleneck.

Prefetch is only useful in conjunction with PBOs. Prefetch will attempt to asynchronously upload upcoming frames to the card ahead of the display frame. This option can add another 20% to display performance in some cases and cause a negative impact in others.

If you’re using a particular image format frequently it’s a good idea to test using PBOs and prefetch to see how they perform on your hardware. To do so: cache a number of frames using the region cache. Make sure realtime mode is NOT on (in other words use play-all-frames mode). Set the target FPS to something impossible like 500 fps. With the preferences render pane open try playing back the frames from cache and see how fast it can go. Turn on and off PBO and prefetch usage to see what happens.

## Playback Sweet Spots

There are a few combinations of hardware and file formats which lead to overall better performance. A couple of those are documented here.

| **Nvidia Core** | **Example Cards** | **10 bit DPX/Cineon and 8 bit JPEG** | **EXR B44/A 16 bit float** |
|-|-|-|-|
| G8x, G9x | GeForce 8800 GT(XS) | Excellent | Excellent |
| GT200 | GeForce GTX 2xx | Excellent | Excellent |
| NV4x | GeForce 6x00 | Good | No Direct Playback |
| NV3x | GeForce FX | Maybe OK | No Direct Playback |

<center>*Nvidia GPUs and known sweetspots with RV for direct from disk*</center>

### 24 FPS 2048x1556 10 Bit DPX From Disk

To achieve 24 fps DPX playback from disk at least a two core CPU with a RAID or other device which can achieve minimum sustained bandwidth of 300+Mb/sec across the whole array and sufficient latency and I/O transactions per second. Using two or more reader threads (depending on the number of available cores) with the look-ahead cache on can result in 24 fps DPX playback. This configuration should be purely *bandwidth limited* meaning that more bandwidth would result in higher FPS.

Not all configurations will work. You may need to experiment.

### OpenEXR 24 FPS 2048x1556 3 Y-RY-BY 16 bit Floating Point B44 and B44A From Disk

OpenEXR decoding benefits from more cores. For best results a 4 or 8 core machine is required. B44 2k full-aperture 4:2:0 sampled files are approximately 4Mb in size so they don’t require as much bandwidth as DPX files of the same resolution. For 4:4:4 sampled or B44A with an alpha channel more bandwidth and cores may be required. Generally speaking you should have about as much bandwidth as similar DPX playback would require.

When decoding EXR files, you have the option of setting both the number of reader threads in RV and the number of decoder threads used by the EXR libraries. The exact numbers depend on the flavor of B44/A files being decoded.

### Individual Desktop Review

For individual desktop review the best quality and economy is undoubtably the use of QuickTime movies encoded with the Photo-JPEG codec. RV can play these back and create them on all three platforms. The image quality is good and the interactivity with the file is excellent (unlike H.264 which is slower when accessed randomly). If large QuickTime files are needed, RV can use multiple threads to decode the QuickTime movies efficiently. Many workstations can handle playback of 2k and 1080p Photo-JPEG QuickTime movies from the desktop using RV.
