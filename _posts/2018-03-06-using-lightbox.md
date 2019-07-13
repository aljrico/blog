---
layout: post
title: "Using Jekyll, Lightbox, and GitHub pages"
author: "Alfredo Hernández"
categories: tech
tags: [blog,documentation,jekyll]
image: html-code.jpg
---

Lightbox is a script used to overlay images on the current page. Its implementation in a pure HTML is fairly easy if you follow the documentation (I used it long ago for a secondary school [project](aldomann.com/sinia) a friend and I did back in 2010).

My idea was to see how this could be implemented in Jekyll using plug-ins or whatever.

I found two nice implementations:
- [Lightbox without plugin](https://jekyllcodex.org/without-plugin/lightbox/#): it uses just a custom HTML file and the jQuery library.
- [Jekyll Lightbox Plugin](https://github.com/appfoundry/jekyll-lightbox): a simple Jekyll tag for including lightbox images.

I didn't like the first because I always prefer to use upstream code, and the second one (although it worked on my local server) couldn't be built on GitHub Pages. The reason is that, apparently, [GitHub will not access any external plugins at all for security reasons](https://github.com/inukshuk/jekyll-scholar/issues/163), so I needed to find an alternative way of doing it.

A the end, looking at the [official documentation](https://jekyllrb.com/docs/includes/), I decided to use define my own `lightbox.html` in the `_includes` folder.

This is my implementation of my `lightbox.html` includes:
{% raw %}
```html
<a href="{{ site.github.url }}/assets/img/{{ include.src }}" data-lightbox="{{ include.data }}" data-title="{{ include.title }}"><img src="{{ site.github.url }}/assets/img/{{ include.src }}" alt="{{ include.title }}"/></a>
```
{% endraw %}

It's pretty much what one would do manually using HTML, but then we only need to *call* it in a post using a Liquid tag:
{% raw %}
```html
{% include lightbox.html src="image.jpg" data="group" title="Sample Title" %}
```
{% endraw %}

Having a better understanding of `includes` in Jekyll, I decided to also create a simple implementation of `image.html` to include static images in posts:
{% raw %}
```html
<img src="{{ site.github.url }}/assets/img/{{ include.src }}" alt="{{ include.title }}"/>
```
{% endraw %}

The use is pretty much the same using a Liquid tag:
{% raw %}
```html
{% include image.html src="image.jpg" title="Sample Title" %}
```
{% endraw %}

I still want to play a bit more with galleries and some other stuff, but for now I'm happy with what I have.
