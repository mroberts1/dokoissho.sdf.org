---
title: "Roguelike development tips"
layout: post
---

Reddit's [/r/roguelikedev](https://www.reddit.com/r/roguelikedev/) is a great
place for discussing roguelike development. One of its most valuable resources
is **FAQ Friday**, a bi-weekly post where developers share their insights about
a specific topic.

There's a huge amount of useful information locked away in these posts, and
they're well worth reading through even if you're not building a roguelike.


## Highlights

Below are a couple of my favourites from the archives. There's so much good
stuff I'll probably be updating this list a lot.

[#5 - Data Management](https://www.reddit.com/r/roguelikedev/comments/2whxdj/faq_friday_5_data_management/)
: Detailed discussion on how different games get data into the game. There's
examples of different file formats and how objects are represented internally in
the game.

[#10 - Project Management](https://www.reddit.com/r/roguelikedev/comments/322c0s/faq_friday_10_project_management/)
: A look at how people organize their projects and how files are
structured. There's also some discussion on what tools are useful for getting
things done on time.

[#24 - World Structure](https://www.reddit.com/r/roguelikedev/comments/3qs4rv/faq_friday_24_world_structure/)
: How worlds are laid out, what kinds of environments are used and how things
are all connected.

[#40 - Inventory Management](https://www.reddit.com/r/roguelikedev/comments/4ndsfx/faq_friday_40_inventory_management/)
: How different games manage their inventories, challenges along the way and
some UI discussion.


## /r/roguelikedev/ "FAQ Friday" archives

**Last update:** 2017-03-19

<ul class="posts-list posts-list--no-indent">
  {% for topic in site.data.roguelike_dev reversed %}
    <li>
      <span class="date">{{ topic.date }}</span>
      -
      <a href="https://www.reddit.com/r/roguelikedev/comments/{{ topic.slug }}/">
        #{{ topic.number }} {{ topic.title }}
      </a>
    </li>
  {% endfor %}
</ul>
