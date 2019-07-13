---
layout: post
title: "How to delay startup applications on GNOME"
author: "Alfredo Hernández"
categories: tech
tags: [linux,documentation]
---

Back in 2017, support for status icons, pictured below, [was removed](https://blogs.gnome.org/aday/2017/08/31/status-icons-and-gnome/) from GNOME Shell (v3.26).

{%include image.html src="https://blogs.gnome.org/aday/files/2017/08/image1.png" %}

This has been a controversial topic (as anything in the GNU/Linux community, really) and probably will always be, but in my opinion there's no point on discussing about it.

One way to use status icons on later versions of GNOME Shell is to install the [(K)StatusNotifierItem/AppIndicator Support](https://extensions.gnome.org/extension/615/appindicator-support/) extension by [Marco Trevisan](https://github.com/3v1n0). As you can see in the picture below, the menu is rendered natively by GNOME Shell instead of Qt/GTK+, so at the end of the day the desktop integration is much more seamless that the old implementation.

{%include image.html src="https://extensions.gnome.org/extension-data/screenshots/screenshot_615.png" %}

The only issue with this is that not all startup applications, those that are automatically started when you log in, that use status icons will show up in the bar. The reason for this, if I'm not mistaken, is that the applications are started before GNOME Shell/the extension is rendered.

## How fix this

After Googling for a couple of minutes, the typical fix for this you'll find on any GNU/Linux forum is that you should add a `sleep` command before executing the application itself on the `.desktop` file (located in `~/.config/autostart/`), like so:

```ini
[Desktop Entry]
Type=Application
Name=Nice App
Exec=bash -c "sleep 10 /opt/niceapp/niceapp -minimize"
Icon=niceapp
Comment=Just a nice application
```

This will effectively delay the startup process of the application for 10 seconds, giving GNOME Shell enough time to initialise before the application, resulting in its status icon showing in the top bar. This solution feels very hacky, though.

A few months ago I discovered that the "proper" way to do this is, however, to use the `X-GNOME-Autostart` parameters in your `.desktop` file instead:

```ini
[Desktop Entry]
Type=Application
Name=Nice app
Exec=/opt/niceapp/niceapp -minimize
Icon=niceapp
Comment=Just a nice app
X-GNOME-Autostart-Delay=10
X-GNOME-Autostart-enabled=true
```

From a UX point of view the result is essentially the same, but this solution is much cleaner in my opinion.
