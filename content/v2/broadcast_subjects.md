---
layout: default
title: Broadcast Subjects
---

<div class="note warning sticky">
   <h2>Not implemented yet!</h2>
   <p>This is just a sneak peek into how this resource might work.</p>
 </div>

* TOC
{:toc}

# The Wildcard Event

There is a special subject, `*`, which you can use to subscribe a webhook to all current & future subjects

# Subjects

<% BROADCAST_RECEIVER_SUBJECTS.each do |subject| %>
- `<%= subject %>`
<% end %>
