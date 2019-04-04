---
layout: default
title: The RVLINK Protocol: Using RV as a URL Handler
permalink: /rv/rv-manual/the-rv-link-protocol/
lang: en
---

# C: The RVLINK Protocol: Using RV as a URL Handler

RV can act as a protocol handler for URLs using the “rvlink” protocol. These URLs have the form:

```
rvlink://<RV commandline>
```

for example,

```
rvlink:// -l -play /path/to/my/movie.mov
```

Will start RV (or on the mac, create a new session or replace the current session), load movie.mov, turn on the look-ahead cache, and start playback.

## Using rvlink URLs

You can insert rvlinks into web pages, chat sessions, emails, etc. Of course it is up to each individual application whether it recognizes the protocol. Some applications can be taught to treat anything of the form “name://” as a link to the name protocol, but others are hard-coded to only recognize “http://”, “ftp://”, etc. Some examples of apps that will recognize rvlinks are

* Firefox
* Safari
* Chrome
* Internet Explorer
* Thunderbird
* Mac Mail
* IChat

One example of an app that will only recognize a hard-coded set of protocol types is Pidgin.

To use an rvlink in HTML, this kind of thing should work:

```
<a href="rvlink: -l -play /path/to/my/movie.mov">play movie</a>
```

**Note** the quotation marks.

In other settings (like pasting into an email, for example) you may want a “web-encoded” URL, since an RV command line can contain arbitrary characters. RV will do the web-encoding for you, if you ask it to do so on the command line. For example, if you run:

```
rv -l -play /path/to/my/movie.mov -encodeURL
```

RV will print the encoded url to the terminal:

```
rvlink://%20-l%20-play%20%2Fpath%2Fto%2Fmy%2Fmovie.mov
```

Some browsers, however, like IE and Konqueror, seem to modify even encoded URLs before they get to the protocol handler. If the rvlink URL contains interesting characters, even an encoded URL will not work with these browsers. To address this issue, RV also supports “fully-baked” URLs, that look like this:

```
rvlink://baked/202d6c202d706c6179202f706174682f746f2f6d792f6d6f7669652e6d6f76
```

This form of URL has the disadvantage of being totally illegible to humans, but as a last resort, it should ensure that the URL reaches the protocol handler without interference. As with encoded URLs, baked URLs can be generated from command-lines by giving RV the “-bakeURL” command-line option. Note that the “baked” URL is just a hex-encoded version of the command line, so in addition to using RV itself, you can do it programmatically. For example, in python, something like

```
"-play /path/to/file.exr".encode("hex")
```

should do the trick.

### A Note on Spaces

In general, RV will treat spaces within the URL as delimiting arguments on the command line. If you want to include an argument with spaces (a movie name containing a space, for example) that argument must be enclosed in single quotes (’). For example, if the name of your media is my movie.mov, the encoded rvlink URL to play it would look like:

```
rvlink://%20'my%20movie.mov'
```

## Installing the Protocol Handler

RV itself is the program that handles the rvlink protocol, so all that is necessary is to register RV as the designated rvlink handler with the OS or desktop environment. This is a different process on each of the platforms that RV supports.

### Windows

On windows the rvlink protocol needs to be added to the registry. If you are using the RV installer for Windows this will happen automatically. If not, you need to edit the “rvlink.reg” file in the “etc” directory of the install to point at the install location, then just double click on this file to edit the registry.

### Mac

Run RV once with the “-registerHandler” command-line option in order to register that executable as the default rvlink protocol handler (this is to prevent confusion between RV and RV64 when both are installed).

### Linux

Unlike Windows and Mac, Linux protocols are registered at the desktop environment level, not the OS level. After you’ve installed RV on your machine, you can run the “rv.install_handler” script in the install’s bin directory. This script will register RV with both the KDE and Gnome desktop environments.

Some application-specific notes:

**Firefox** may or may not respect the gnome settings, in general, I’ve found that if there is enough of the gnome environment installed that gconfd is running (even if you’re using KDE or some other desktop env), Firefox will pick up the gnome settings. If you can’t get this to work, you can register the rvlink protocol with Firefox directly.

**Konqueror** sadly seems to munge URLs before giving them to the protocol handler. For example by swapping upper for lowercase letters. And sometimes it does not pass them on at all. This means some rvlink URLs will work and some won’t, so we recommend only “baked” rvlink urls with Konqueror at the moment.

**Chrome** uses the underlying system defaults to handle protocols. In most cases this means whatever “xdg-open” is configured to use. Running the rv.install_handler should be sufficient

## Custom Environment Variables

Depending on the browser and desktop environment, **environment variables** set in a user environment may not be available to RV when started from a URL. If RV in your setup requires these **environment variables** (RV_SUPPORT_PATH, for example), it may have problems or not run at all when started from a URL. In order to ensure a consistent environment, you must ensure that these **environment variables** are set at a system-wide (or at least user-independent) level. On Linux, setting this up varies from distribution to distribution. You will want to research the appropriate steps for your distribution. On Windows, the usual **environment variable** techniques should work. MacOS has lately made this harder, but if you set the **environment variables** in /etc/launchd.conf (and reboot after setting), then the values should be picked up by all processes on the system.

## Testing the Protocol Handler

Once RV is properly registered as the rvlink protocol handler, go to this page to try it out [on the rvlink test page](http://tweaksoftware.com/rvlink-test-page).
