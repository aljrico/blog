---
layout: post
title: "Including images with Liquid"
author: "Alfredo Hernández"
categories: tech
tags: [blog,documentation,jekyll]
image: html-code.jpg
---

A while ago I covered on [_Using Jekyll, Lightbox, and GitHub pages_]({{ site.baseurl }}{% post_url 2018-03-06-using-lightbox %}) how to use `includes` in Jekyll/Liquid to simplify the process of adding images to your posts.

The process is pretty simple, but you need two different files (and syntaxes) for essentially the same thing: showing an image. This probably makes sense from a technical point of view, but it's just cumbersome to use.

I also realised I had no way of displaying images from external sources (i.e., from an URL), so I decided to revamp my `includes` and merge them into just one that can:

- Handle URL and local images easily.
- Use Lightbox if needed.

## Implementation

I didn't want to use different variables to handle local images and URLs, so my idea was to use pattern matching in the `src` variable to check if it is an URL, like so:

{% raw %}
```html
{% unless include.src contains 'http' %}
  <img width="{{ include.width }}" src="{{ '/assets/img/' | prepend: site.baseurl | replace: 'http://', 'https://' }}{{ include.src }}" alt="{{ include.title }}"/>
{% else %}
  <img width="{{ include.width }}" src="{{ include.src }}" alt="{{ include.title }}"/>
{% endunless %}
```
{% endraw %}

I'm using the `unless` control flow tag instead of `if`, as I will be using local images more often than not. As a result, the build process should be faster (negligibly so, but it's always a good practice to think about the evaluation process of your code).

For handling Lightbox, I'm doing pretty much the same, so I'll spare the explanation. At the end, I ended up with a pretty straightforward implementation:
{% raw %}
```html
{% unless include.lightbox == "true" %}
  {% unless include.src contains 'http' %}
  <img width="{{ include.width }}" src="{{ '/assets/img/' | prepend: site.baseurl | replace: 'http://', 'https://' }}{{ include.src }}" alt="{{ include.title }}"/>
  {% else %}
  <img width="{{ include.width }}" src="{{ include.src }}" alt="{{ include.title }}"/>
  {% endunless %}
{% else %}
  {% unless include.src contains 'http' %}
  <a href="{{ '/assets/img/' | prepend: site.baseurl | replace: 'http://', 'https://' }}{{ include.src }}" data-lightbox="{{ include.data }}" data-title="{{ include.title }}"><img width="{{ include.width }}" src="{{ '/assets/img/' | prepend: site.baseurl | replace: 'http://', 'https://' }}{{ include.src }}" alt="{{ include.title }}"/></a>
  {% else %}
  <a href="{{ include.src }}" data-lightbox="{{ include.data }}" data-title="{{ include.title }}"><img width="{{ include.width }}" src="{{ include.src }}" alt="{{ include.title }}"/></a>
  {% endunless %}
{% endunless %}
```
{% endraw %}

## Usage

In my Markdown templates I'm using the snippet below:

{% raw %}
```html
{% include image.html lightbox="false" src="file.jpg" data="group" title="Image title" width="100%" %}
```
{% endraw %}

By default, when using standard images, the `lightbox` and `data` variables are not needed; the former doesn't really need to be `false` (it just needs to be not `true`, which is different), and the later is only evaluated when using Lightbox.

The `width` variable is also optional. By default, my CSS code forces the `max-width` to be `100%`, so big images will be shrank down to the text width, and smaller images will be displayed at real size. Sometimes, however, I want to force big images to be `50%` of the text width (or any other value).

That being said, I prefer to include all these variables in my template to ease the use of the `include`, as it's always easier to remove parts of the snippet than to remember the entire syntax.

