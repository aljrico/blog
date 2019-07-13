---
layout: post
title: "Running JupyterLab as a desktop application on Linux"
author: "Alfredo Hernández"
categories: [tech,data-science]
tags: [linux,programming,python]
---

JupyterLab has quickly become the standard for doing Data Science in Python. Arguably, the main reason for this is the notebook format, an idea introduced back in 1986 in the amazing [Wolfram Mathematica](http://www.wolfram.com/notebooks/).

But the fact is there are just no decent alternatives. [Rodeo](https://github.com/yhat/rodeo) seemed to be a very promising IDE focused on Data Science with a UI/UX very similar to RStudio's, but its development stopped in early 2017. So yeah...

One thing that you may find annoying with JupyterLab is the fact that it opens in a tab of your Internet browser, when it should clearly have its own window. This will be a guide on how to make this happen.

## Run Jupyter in application mode with Google Chrome

The way most people run Jupyter Lab is to open a terminal and just run
```bash
jupyter lab
```
This automatically opens a tab on your browser with your JupyterLab session.

What I didn't know until yesterday, is that you can add the `--no-browser` option to the previous command to start the JupterLab server only. The output should look like this:
```bash
...

To access the notebook, open this file in a browser:
		file:///run/user/1000/jupyter/nbserver-11009-open.html
	Or copy and paste one of these URLs:
		http://localhost:8888/?token=aab291459688c14eb90fe459e36ee6da56f7579dcd1c8fc8
```

Now you could either copy the link and open it in a new tab, which would totally defeat our goals, or open it with [Chrome in application mode](https://stackoverflow.com/a/20663518/988432):

```bash
google-chrome-stable --app=http://localhost:8888/?token=aab291459688c14eb90fe459e36ee6da56f7579dcd1c8fc8
```

This will open JupyterLab in its own window, just as we wanted:
{% include image.html lightbox="true" src="jupyter-window-linux.png" data="group" title="JupyterLab Window"  %}

This may also be possible with [GNOME Web](https://help.gnome.org/users/epiphany/stable/browse-webapps.html.en), but I haven't tested it.

## Make this change permanent

Running two commands for opening a single GUI application is probably more annoying than having an IDE in a browser tab. So let's make this change permanent.

The way to do this is by simply modifying a config file to change the default browser for JupyterLab.

If you've never modified the default JupyterLab configuration in the past, you'll need to run the following command to generate a config file:
```bash
jupyter lab --generate-config
```

This will create the `~/.jupyter/jupyter_notebook_config.py` file. You can open this file on your text editor of choice and add the following line to it:
```bash
c.LabApp.browser = 'google-chrome-stable --app=%s'
```

Additionally, you can change the default directory of your notebooks when you open JupyterLab by adding the following line as well:
```bash
c.NotebookApp.notebook_dir = '/home/<user>/Code/Python'
```

Note that you can't browse files outside of this path from JupyterLab's File Browser, as this will act as your Home. This will also be the opened directory regardless of where you run `jupyter lab` from, so think about your workflow before you make this change. At the end of the day, this step becomes unnecessary when you create a launcher, so I wouldn't really recommend doing it.

## Create a launcher

This is nice and all, but we can go a step further and create an application launcher that we can pin to our Dash/Dock/Panel. This is surprisingly easy in Linux, thanks to the [Desktop Entry Specification](https://standards.freedesktop.org/desktop-entry-spec/latest/).

We just need to create a `.desktop` file running the following command:
```bash
touch ~/.local/share/applications/jupyter-lab.desktop
```

Then open it on your text editor of choice and paste the following contents:
```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=JupyterLab
GenericName=JupyterLab
Comment=JupyterLab is the next-generation web-based user interface for Project Jupyter
Keywords=python;tensorflow;keras
Exec= bash -c "/usr/bin/env PATH=/home/<user>/.anaconda3/bin/:$PATH /home/<user>/.anaconda3/bin/jupyter lab --notebook-dir '~/Code/Python'"
StartupWMClass=Google-chrome
Categories=Development;Science;IDE;Qt;
Icon=jupyter-lab
Terminal=true
StartupNotify=true
MimeType=text/x-python3;text/x-python;application/x-ipynb+json;
```

Then just restart your graphical session, and you'll find JupyterLab in your applications launcher:

{% include image.html lightbox="true" src="jupyter-launcher-linux.png" data="group" title="JupyterLab Launcher"  %}

## Fix Google Chrome

You may have noticed the following line in the contents of `jupyter-lab.desktop` above:
```ini
StartupWMClass=Google-chrome
```

This is, simply said, a dirty hack and will make Google Chrome's windows be handled by JupyterLab's icon. The explanation of why this happens is quite long, and probably deserves its own post.

This is easy to fix, thankfully. First, we need to copy the system's `.desktop` file for Google Chrome on our local directory:
```bash
cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
```

Then we need to edit the `StartupWMClass` line on `google-chrome.desktop` to
```ini
StartupWMClass=google-chrome
```

This will make your system treat Google Chrome and JupyterLab as separate applications.

## Use an icon for the launcher

I personally use the [Moka Icon Theme](https://github.com/snwh/moka-icon-theme) by Sam Hewitt, with [my own extra icons](https://gitlab.com/aldomann/moka-extra-icons), so I got that covered.

If you just prefer to use a theme-agnostic icon, you can download the SVG file below (I couldn't find the logo in SVG or PNG, so I recreated it from scratch) and save it in `~/.local/share/icons`.

{% include image.html lightbox="false" src="jupyter-lab.svg" data="group" title="Image title" %}

