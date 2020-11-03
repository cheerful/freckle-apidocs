---
layout: v2
title: Webhooks
---

<div class="note warning">
 <h2>In Beta!</h2>
 <p>Webhooks and Broadcasts are in beta while we make sure they're rock solid. The specs are finalized though, so they're safe to add to your integration!</p>
</div>

This API allows you to manage your webhooks entirely from the API, so you can set up your integrations automatically without requiring any user configuration.

* TOC
{:toc}

## List Webhooks

Get all webhooks, sorted by the most recently created

~~~
GET /v2/webhooks
~~~

name
: *Optional* **string**
: Only webhooks containing this text in their name are returned.
: Example: `name=Notifier`

events
: *Optional* **string**
: A comma-separated list of [events](/v2/webhook_events/) to filter by.
: Example: `events=entry.updated,entry.updated.approved`

state
: *Optional* **string**
: Only webhooks in this state will be returned. Accepted Values are:

    * `enabled`
    * `disabled`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "webhooks" %>
<%= json_array :webhook %>


## Get a single Webhook

~~~
GET /v2/webhooks/:id
~~~

<%= headers 200 %>
<%= json :webhook %>

## Create a Webhook

~~~
POST /v2/webhooks/
~~~

### Inputs

name
: *Required* **string**
: The name of the Webhook

payload_uri
: *Required* **string**
: The URI to send the payloads to.

events
: *Required* **array of strings**
: The [events](/v2/webhook_events/) this webhook should be subscribed to.
: You can also specify `'*'`, which is a wildcard for all current and future events.

<%= json :webhook_create_fields %>

### Response

<%= headers 201, :Location => "#{API_V2_URL}/webhooks/123456"  %>
<%= json :created_webhook %>

### Storing your webhook's secret.

You will only receive the webhook's `secret` when first creating the webhook, so make sure to store it!


## Edit a Webhook

~~~
PUT /v2/webhooks/:id
~~~

### Inputs

name
: *Optional* **string**
: The name of the Webhook

payload_uri
: *Optional* **string**
: The URI to send the payloads to.

<%= json :webhook_edit_fields %>

### Response

<%= headers 200 %>
<%= json :webhook %>

## Add events to a Webhook

~~~
PUT /v2/webhooks/:id/add_events
~~~

### Inputs

events
: *Required* **array of strings**
: The [events](/v2/webhook_events/) this webhook should be subscribed to. Any events the webhook is already subscribed to will be ignored and will not affect the response.
: You can also specify `'*'`, which is a wildcard for all current and future events.

<%= json :webhook_edit_events_fields %>

### Response

<%= headers 200 %>
<%= json :webhook %>


## Remove events from a Webhook

~~~
PUT /v2/webhooks/:id/remove_events
~~~

### Inputs

events
: *Required* **array of strings**
: The [events](/v2/webhook_events/) this webhook should not be subscribed to. Any events the webhook is not already subscribed to will be ignored and will not affect the response.

<%= json :webhook_edit_events_fields %>

### Response

<%= headers 200 %>
<%= json :webhook %>


## Re-roll a Webhook's secret

~~~
PUT /v2/webhooks/:id/reroll_secret
~~~

### Response

<%= headers 200 %>
<%= json :webhook_secret_data %>

## Disable a Webhook

~~~
PUT /v2/webhooks/:id/disable
~~~

### Response

<%= headers 204 %>


## Enable a Webhook

~~~
PUT /v2/webhooks/:id/enable
~~~

### Response

<%= headers 204 %>

## Ping a Webhook

~~~
PUT /v2/webhooks/:id/ping
~~~

### Response

<%= headers 202 %>


## Retry a Webhook Payload

~~~
PUT /v2/webhooks/:id/retry/:payload_id
~~~

### Response

<%= headers 202 %>

## Delete a Webhook

~~~
DELETE /v2/webhooks/:id
~~~

### Response

<%= headers 204 %>