---
layout: post
title: "Disabling GRUB graphical theme"
author: "Alfredo Hernández"
categories: tech
tags: [linux,documentation]
---

I've been using Antergos/Arch Linux for a couple of years after switching from Ubuntu GNOME, and although I don't dislike the shipped graphical GRUB theme (depicted below), I always found it unnecessary and in some resolutions the background image is stretched.

{% include image.html lightbox="true" src="grub-graphic.png" data="group" title="Default GRUB theme shipped with Antergos" %}

So, after years of just being lazy and not really wanting to do it on my machine, I decided to just run a Virtual Machine and test how to properly do it without breaking the system (GRUB is one of those things you don't want to break; although doing it is not that difficult to fix, just annoying).

## Steps to follow
The process is quite straightforward. First, we need to open GRUB's config file on our text editor of choice:
```bash
sudo nano /etc/default/grub
```
The only thing to do in this file is to comment the following line (you can use <kbd>Ctrl</kbd> + <kbd>W</kbd> on Nano to search for `GRUB_THEME`):
```bash
#GRUB_THEME="/boot/grub/themes/Antergos-Default/theme.txt"
```
This will essentially make GRUB look like this (our goal):
{% include image.html lightbox="true" src="grub-text.png" data="group" title="Gorgeous unremarkable text-based GRUB" %}


If you wish to change the colours you could uncomment the following lines and [set them to your preferred colours](https://www.gnu.org/software/grub/manual/legacy/color.html):
```bash
# Uncomment and set to the desired menu colors.  Used by normal and wallpaper
# modes only.  Entries specified as foreground/background.
GRUB_COLOR_NORMAL="light-blue/black"
GRUB_COLOR_HIGHLIGHT="light-cyan/blue"
```

## Applying the changes

To apply the changes to your system, just run the following command to rebuild the config file used in the boot process:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
DO NOT, by any means, attempt to edit this file manually, you'll likely hate yourself after doing it.

After the config file is finished building, you just need to reboot your system to see the changes.

## Other things to change
Although this is not the topic of the post, one thing you may want to change, is the time-out before the default boot option is automatically selected (the default is 5 seconds):
```bash
GRUB_TIMEOUT=3
```
I would personally recommend around 3 seconds as it's fast enough and gives you enough time to change the selected boot option, especially if you have a dual boot set-up in your machine.

In any case, don't set it to `0`, as it will default to 5 seconds. There are ways to hide the GRUB boot menu altogether, but I haven't personally tested anything; that may be for another future post.
