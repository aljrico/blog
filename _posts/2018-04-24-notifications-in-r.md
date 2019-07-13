---
layout: post
title: "Getting system notifications with R"
author: "Alfredo Hernández"
categories: [data-science,tech]
tags: [linux,r,programming]
---

So today I was making quite time consuming simulations in R, and I was wondering if there was a way to know when the simulations were finished so I could have a look at the results. Relevant xkcd:

{% include image.html src="https://imgs.xkcd.com/comics/compiling.png" data="group" title="Custom resource records" %}

For those familiar with bash scripting in Linux, you can use `notify-send` to, well, send desktop notifications using the `libnotify` library. For those familiar with R, you may also know that R can directly execute system commands using the `system()` function.

Having this in mind, the answer to my problem was just creating a function that
 - can execute any[^fn1] R call
 - prints the elapsed time to execute it
 - sends a permanent desktop notification
 - emits a *completion* alert sound[^fn2]

*Of course*, I decided to call the function `lok_regar()`:
```r
lok_regar <- function(call) {
	print(system.time(call))
	system("notify-send -i rstudio -u critical 'Finished calculations' 'Get back to work!'")
	system("paplay /usr/share/sounds/freedesktop/stereo/complete.oga")
}
```

I'm not sure this function is the most elegant way to do this, but it's pretty easy to use and does its job, and it looks pretty:

{% include image.html src="r-notify.png" data="group" title="Custom resource records" %}

In the future I would like to print the elapsed time into the notification itself, but I'm not quite sure it's possible.

[^fn1]: Well, probably not any, but it works in the scenarios I've tested it.
[^fn2]: It doesn't always work, I don't know why.
