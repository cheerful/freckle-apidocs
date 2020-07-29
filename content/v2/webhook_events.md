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


# The Ping Event

There is a special event, `webhook.ping`, which is fired when a webhook is created, or when you manually trigger a ping from the Webapp or [Webhooks Endpoint](/v2/webhooks/#ping-a-webhook)

# Entry Events

<% WEBHOOK_ENTRY_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>


# Tag Events

<% WEBHOOK_TAG_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>