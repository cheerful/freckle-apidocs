---
layout: default
title: Webhook Events
---

<div class="note warning sticky">
   <h2>Not implemented yet!</h2>
   <p>This is just a sneak peek into how this resource might work.</p>
 </div>

* TOC
{:toc}

# The Wildcard Event

There is a special event, `*`, which you can use to subscribe a webhook to all current & future events

# Entry Events

<% WEBHOOK_ENTRY_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>