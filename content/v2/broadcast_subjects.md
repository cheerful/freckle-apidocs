---
layout: default
title: Broadcast Subjects
---

* TOC
{:toc}

# The Wildcard Event

There is a special subject, `*`, which you can use to subscribe a webhook to all current & future subjects

# Subjects

<% BROADCAST_RECEIVER_SUBJECTS.each do |subject| %>
- `<%= subject %>`
<% end %>
