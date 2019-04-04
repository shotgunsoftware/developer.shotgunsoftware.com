---
layout: default
title: Command Line Invocation
permalink: /rv/rv-sdi-manual/command-line-invocation/
lang: en
---

# Command Line Invocation

You can start RVSDI like this to fully specify

To use the -presentDevice option you could do e.g.:

```
rvsdi -presentDevice AJA/Kona3GQuad
```

for the first SDI device.

These can also be set using the prefs by selecting the “Use as Presentation Device” check box.

The -presentVideoFormat and -presentDataFormat will search for a video or data format that contains the passed in string. So for SDI you could do:

```
rvsdi -presentVideoFormat "1080p 24Hz" -presentDataFormat "Dual"
```

which would find “1080p 24Hz SMPTE274” as the video format and “Dual 8 Bit YCrCb 4:2:2” as the data format. Some other examples:

```
rvsdi -presentVideoFormat "720p" -presentDataFormat "4:4:4"
```

would be 8 bit 720p 59.94Hz because that is the first 720p format. The first matching data format to 4:4:4 is 8 bit YCrCb 4:4:4. You can be more specific like:

```
rvsdi -presentVideoFormat "720p 60Hz" -presentDataFormat "10 Bit YCrCb 4:4:4"
```

RV will pick the first video or data format that contains the passed in string. These strings are device dependent. Ideally you specify the entire string as it appears in the preferences.

To force audio output:

```
rvsdi -presentAudio 1
```

or

```
rvsdi -presentAudio 0
```

for no audio.
