---
layout: post
title:  "Adding Comments to a Jekyll Blog"
description: "Comparison of Staticman and Utterances to integrate comments into a static blog."
date: 2020-09-03 18:00 +0200
tags: jekyll
categories: programming
comment_issue_term: "Jekyll Comments Integration"
redirect_from: 
  - /programming/2020/09/03/comments.html
  - /programming/2020/09/03/adding-comments-to-a-jekyll-blog.html
---

I'm pretty happy with Jekyll and the static HTML pages it creates, but one thing every Wordpress blog features is clearly missing: a comment section.
Yes, it mostly collects either dust or bitcoin scams these days, but there's still the chance someone actually has a question or remark about the thing I wrote.

While I could have built a simple service myself, I'd then have to take care of e.g. spam filtering and generally maintaining it,
so I decided to use something existing. Of course Disqus came to mind, but if I'd include that into my page, I could as well add
GA and a facebook pixel for good measure.

Surely I wasn't the first one with this problem, so I searched for a bit. There were a lot of possible solutions (many of them no longer maintained),
 but two of them really caught my eye: **Staticman** (no longer available) and [utterances](https://utteranc.es/){:target="_blank"}.

Both of them are open source and use Github as "database" for comments, but in very different ways. Let's take a look:

## Staticman

Staticman uses Github **pull requests** to add new comments as actual files to the homepage repo. You just have to point your comment form to
the Staticman API, add the `staticmanapp` to your repo (so it can create the PRs) and you're good to go.

Every time a user submits the comment form, a new PR is created and - depending on your configuration - automatically merged or
marked for review. Each PR contains a simple `YAML` file with the form data the user submitted which can easily be processed by Jekyll during compilation 
(see [here](https://github.com/eduardoboucas/popcorn){:target="_blank"} for an example repo).

Staticman can be self-hosted and comes with a lot of additional features like Akismet integration for spam checking or Mailgun for
email notifications about new comments, but it's its main feature that made me not choose it: It automatically alters my repository.

I like the idea of having my whole page as static files, including comments, but to be honest: As long as the comments are stored in
a database outside my page, I can still move it to a different server without losing anything. And I really don't like the idea of
a service pushing code to my repository with whatever a user writes into a comments form (even if I review them before).

This brings us to the second point I'm not really happy about: Staticman saves exactly what the user entered into the form
in the repo for me to render in my layout. While this allows for a lot of customization (the demo page uses it for movie reviews),
I still have to add the convenience for the user myself. Also, I'd have to make sure all user content is properly sanitized.

### Short version:

**Pros**

* Users don't need a Github account to comment
* Integration with Akismet for spam filtering
* Comments can contain custom fields like a star score (0-5)

**Cons**

* Adds user generated content to my repo (I know, that's the gimmick, but still...)
* Rendering the comments in Jekyll has to be built, including proper sanitizing

## utterances

*utterances* uses Github **issues** to store user comments. 
It does so by sending XHR requests to its API (also open source) which communicates with the Github API behind the scenes.

When the first user creates a comment on a post, a new issue is automatically created on Github. For each additional comment,
the same issue is re-used by adding a comment to its thread. Their [index page issue](https://github.com/utterance/utterances/issues/1){:target="_blank"} is probably
the best example for how this works.

Compared to *Staticman*, the installation is pretty easy. You just have to insert a `<script>` tag into your page with
some configuration options and you're good to go.

The script automatically fetches all existing comments and inserts them into the page in Github's own style, making a user
feel pretty much at home. It also inserts a form to add more comments which pretty much behaves like its equivalent on Github, minus
the formatting toolbar. It does have full GFM support though.

Using the Github API like this leads to two requirements for a user to comment:

**1. They need a Github account to comment (since they are basically commenting on a Github issue)**

I honestly see this as a positive point. I'll mostly write about tech stuff and most of the people who might end up here will have a Github account.
This should also act as a Spam filter to some degree as at least the drive by bots won't be able to comment.

**2. They have to allow the utterances Github app to "act on their behalf" to post the comment.**

Allowing a Github application to access your account is always a tricky decision. Since their API is also open source, I could host it myself, but
I think that's even worse. While I'd know for sure that it's harmless, people would have to give access to a "stex.codes" application... I think it's easier to 
go with the 3k stars one on Github than with my own installation.  

Also, Github makes it pretty clear that a comment wasn't made by the user directly:

<div class="text-center">{{ "/assets/images/posts/comments-bot.png" | lightbox_image: "Bot-posted comment example" }}</div>

Alternatively, the user can of course add the comment directly on Github, making having an account there the only requirement.

### Short version:

**Pros**

* Easy setup through a `<script>` tag
* It feels like writing a Github comment and looks like a Github comment (and is a Github comment).
* It requires a Github account to comment.

**Cons**

* It requires a Github account to comment.
* The user has to give the utteranc.es Github app the permission to "act on their behalf"

## Conclusion

As you can see on this page, I went with *utterances*.  
Since both the library and Github application are open source, I'm fine with using it myself. 
It might lead to fewer people commenting (if someone makes it here anyway that is), but I like the issue flow
a lot more than *Staticman*'s PR approach. Both are very interesting from a technical standpoint though.

Regarding placement and styling, I went with the default Github dark mode for now, but will change that to another
white container below the post. It will be easier to read.

---

**Update (06.09.2020/18.01.2020)**

*utterances* by default places the content of the `<title>` attribute inside its issue names and uses it to find the matching issue for a post.  
I changed this post's title and sure enough the comments were gone.

To work around this, I decided to use an own term to put into the issue per page and use its URL as fallback. This way, I have a little more freedom
to change posts after publishing them.

```html
{%- raw -%}
{% unless page.hide_comments %}
  <script src="https://utteranc.es/client.js"
          repo="stex/stex.codes"
          issue-term="{% if page.comment_issue_term %}{{ page.comment_issue_term }}{% else %}url{% endif %}"
          label="comment"
          theme="github-dark"
          crossorigin="anonymous"
          async
  ></script>
{% endunless %}
{% endraw -%}
```

This allows setting the issue term in the posts [front matter](https://jekyllrb.com/docs/front-matter/) as `comment_issue_term: Something` or hide comments completely by providing `hide_comments: true`.
