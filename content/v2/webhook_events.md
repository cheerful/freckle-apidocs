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


# Project Events

<% WEBHOOK_PROJECT_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>


# Project Group Events

<% WEBHOOK_PROJECT_GROUP_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>

# Invoice Events

<% WEBHOOK_INVOICE_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>


# Expense Events

<% WEBHOOK_EXPENSE_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>


# Team Events

<% WEBHOOK_TEAM_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>


# User Events

<% WEBHOOK_USER_EVENTS.each do |event| %>
- `<%= event %>`
<% end %>