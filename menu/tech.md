---
layout: default
title: Tech Stuff
pagination:
  enabled: true
  per_page: 5
  category: tech
---

{% for post in paginator.posts %}
  {% if post.categories contains "tech" %}
  <div class="posts">
    <h1>
      <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </h1>
    {% if post.image %}
    <div class="thumbnail-container">
      <a href="{{ site.baseurl }}{{ post.url }}"><img src="{{ '/assets/img/thumbnails/' | prepend: site.baseurl | replace: 'http://', 'https://' }}{{ post.image }}"></a>
    </div>
    {% endif %}
    <p>
      {{ post.content | strip_html | truncate: 350 }} <a href="{{ site.baseurl }}{{ post.url }}">Read more</a>
      <span class="post-date"><i class="fa fa-calendar" aria-hidden="true"></i> {{ post.date | date_to_string }} - <i class="fa fa-clock-o" aria-hidden="true"></i> {% include read-time.html %}</span>
    </p>
  </div>
  {% endif %}
{% endfor %}

<!-- Pagination links -->
<div class="pagination">
  {% if paginator.next_page %}
    <a class="pagination-button pagination-active" href="{{ site.baseurl }}{{ paginator.last_page_path }}">{{ site.data.settings.pagination.first_page }}</a>
  {% else %}
    <span class="pagination-button">{{ site.data.settings.pagination.first_page }}</span>
  {% endif %}

  {% if paginator.next_page %}
    <a class="pagination-button pagination-active" href="{{ site.baseurl }}{{ paginator.next_page_path }}">{{ site.data.settings.pagination.previous_page }}</a>
  {% else %}
    <span class="pagination-button">{{ site.data.settings.pagination.previous_page }}</span>
  {% endif %}

  <p class="pagination-button">{{ paginator.page }} / {{ paginator.total_pages }}</p>

  {% if paginator.previous_page %}
    <a class="pagination-button pagination-active" href="{{ site.baseurl }}{{ paginator.previous_page_path }}">{{ site.data.settings.pagination.next_page }}</a>
  {% else %}
    <span class="pagination-button">{{ site.data.settings.pagination.next_page }}</span>
  {% endif %}

  {% if paginator.previous_page %}
    <a class="pagination-button pagination-active" href="{{ site.baseurl }}{{ paginator.first_page_path }}">{{ site.data.settings.pagination.last_page }}</a>
  {% else %}
    <span class="pagination-button">{{ site.data.settings.pagination.last_page }}</span>
  {% endif %}
</div>
