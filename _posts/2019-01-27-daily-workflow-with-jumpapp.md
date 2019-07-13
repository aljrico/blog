---
layout: post
title: "Improve your daily workflow with jumpapp"
author: "Alfredo Hernández"
categories: [tech]
tags: [linux]
---

Most "advanced" users will always recommend using keyboard shortcuts whenever possible, no matter which system or application you are using. In this post I'm going to touch the process of launching applications.

In modern desktops, you'll have stuff like Activities Overview on GNOME Shell, Spotlight on macOS, or any smart launcher of sorts.

Although using these is a definite improvement over using your mouse to launch an app, I prefer to have specific shortcuts for my most used apps. In GNOME, you can just go to the Keyboard settings (depicted below) and add some on your own.
{% include image.html lightbox="true" src="jumpapp-keyboard-settings.png" data="group" title="Keyboard Settings on GNOME"  %}

As an example, I launch Sublime Text just by pressing <kbd>Super</kbd> + <kbd>X</kbd>, as depicted below:
{% include image.html lightbox="true" src="jumpapp-sublime-text.png" data="group" title="Sublime Text shortcut" %}

The thing is most shortcuts defined like this will open a new window of such application, even if you have one open already. This may be good (and even desirable) for some specific applications, but most of the time, you just want to go back to your previously opened window, where you have all your necessary projects/tasks (e.g., an IDE).

This is, surprisingly, the exact behaviour of Sublime Text. Even if you run `subl` on the terminal, it will just focus your opened window. I freaking love this and I need this in all my apps.

## Is this even possible?

Here's where [jumpapp](https://github.com/mkropat/jumpapp) by [Michael Kropat](https://github.com/mkropat) comes in handy. I don't think I can describe jumpapp better than Michael, so I won't bother:

> The idea is simple — bind a key for any given application that will:
>
> - launch the application, if it's not already running, or
> - focus the application's window, if it is running
>
> Pressing the key again will cycle to the application's next window, if there's more than one.
>
> In short, jumpapp is probably the fastest way for a keyboard-junkie to switch between applications in a modern desktop environment.

This is *exactly* what we were looking for. Okay, so now we know we can achieve our goal, but how?

## Using jumpapp

The awesome thing about jumpapp is that it tackles the problem in a very usable way. You don't need to modify the `.desktop` file of your apps or anything like that. You just modify the shortcut.

But first of all we need to install jumpapp. The developer provides [binaries](https://github.com/mkropat/jumpapp/releases) for Debian based systems and Fedora based systems, and for Arch Linux you can get it from the [AUR](https://aur.archlinux.org/packages/jumpapp-git/).

Once that is done, we just need to modify our shortcuts by prepending `jumpapp` to the command option:
{% include image.html lightbox="true" src="jumpapp-nautilus.png" data="group" title="Nautilus shortcut" %}

This is the only required step for 99% of your applications. So what are the other 1%?

- Applications that have command options on the shortcut.
- Weird ass applications.

As an example for the first case, I'll use Wolfram Mathematica. I don't like splash screens, so I always run Mathematica with the `--noSplashScreen` option. This means I have to run my shortcut as a call of a bash command:
```bash
bash -c "jumpapp /home/aldomann/.Wolfram/Mathematica/11.0/Executables/Mathematica --noSplashScreen"
```

As an example for the second case, I'll use Telegram Desktop. For some reason, the binary name, and the process name are not the same. To start the application you need the binary name, but jumpapp uses the processname for switching apps. The way to solve this was to use a logical OR operation in the bash command:
```bash
bash -c "jumpapp telegramdesktop || telegram-desktop"
```

This will first try to start the `telegramdesktop` or jump to it. Since there is no such process or binary called like that, it will run `telegram-desktop`. Once `telegramdesktop` is running, everything behaves like expected.

I haven't experienced this with any other application so far, but it could happen, so there's that.

## Opening new windows

Our workflow is one thousand times better and life is great now, but... how do we open new windows?

For this, we just use the standard methods. This might mean opening a new RStudio session from the menu bar, or pressing <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>N</kbd> on Sublime Text, as an example.

But my favourite way to do it is just to middle click the application launcher on my Dash, as it works universally on pretty much any application.
