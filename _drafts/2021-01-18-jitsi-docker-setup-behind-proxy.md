---
layout: post
title:  "Running Jitsi Meet with Docker behind an Nginx Proxy"
description: "Using the latest version (currently stable-5142-4) of Jitsi Meet with working websocket connection in a Docker setup (with common problems)"
date: 2021-01-18
tags: jitsi docker websockets nginx
categories: programming
comment_issue_term: "Running Jitsi Meet with Docker and Nginx Proxy"
excerpt_separator: <!--more-->
---

Hosting an own instance of Jitsi Meet should be fairly easy as they provide a complete Docker setup (include `docker-compose` file) and installation instructions, right? 

No, at least not if you're planning to run it behind an outer proxy that does SSL termination. I finally managed to get everything up and running and hope I can save others a bit of time until the official documentation or help forums cover the more common problems.

<!--more-->

* Jitsi Repo with Docker-Compose (+ Explanag)
* Setup Script
* Websocket connection to XMPP
* Custom Config for Web Container
