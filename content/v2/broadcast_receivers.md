---
layout: v2
title: Broadcast Receivers
---

This API allows you to manage your broadcast receivers entirely from the API, so you can set up your integrations automatically without requiring any user configuration.

* TOC
{:toc}

## List Broadcast Receivers

Get all broadcast receivers, sorted by the most recently created

~~~
GET /v2/broadcast_receivers
~~~

name
: *Optional* **string**
: Only broadcast receivers containing this text in their name are returned.
: Example: `name=Notifier`

subjects
: *Optional* **string**
: A comma-separated list of [subjects](/v2/broadcast_subjects/) to filter by.
: Example: `subjects=entry.updated,entry.updated.approved`

state
: *Optional* **string**
: Only broadcast receivers in this state will be returned. Accepted Values are:

    * `enabled`
    * `disabled`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "broadcast_receivers" %>
<%= json_array :broadcast_receiver %>


## Get a single Broadcast Receiver

~~~
GET /v2/broadcast_receivers/:id
~~~

<%= headers 200 %>
<%= json :broadcast_receiver %>

## Create a Broadcast Receiver

~~~
POST /v2/broadcast_receivers/
~~~

### Inputs

name
: *Required* **string**
: The name of the Broadcast Receiver

payload_uri
: *Required* **string**
: The URI to send the payloads to.

subjects
: *Required* **array of strings**
: The [subjects](/v2/broadcast_subjects/) this broadcast receiver should be subscribed to.
: You can also specify `'*'`, which is a wildcard for all current and future subjects.

<%= json :broadcast_receiver_create_fields %>

### Response

<%= headers 201, :Location => "#{API_V2_URL}/broadcast_receivers/123456"  %>
<%= json :created_broadcast_receiver %>

### Storing your broadcast receiver's secret.

You will only receive the broadcast receiver's `secret` when first creating the broadcast receiver, so make sure to store it!


## Edit a Broadcast Receiver

~~~
PUT /v2/broadcast_receivers/:id
~~~

### Inputs

name
: *Optional* **string**
: The name of the Broadcast Receiver

payload_uri
: *Optional* **string**
: The URI to send the payloads to.

<%= json :broadcast_receiver_edit_fields %>

### Response

<%= headers 200 %>
<%= json :broadcast_receiver %>

## Add subjects to a Broadcast Receiver

~~~
PUT /v2/broadcast_receivers/:id/add_subjects
~~~

### Inputs

subjects
: *Required* **array of strings**
: The [subjects](/v2/broadcast_subjects/) this broadcast receiver should be subscribed to. Any subjects the broadcast receiver is already subscribed to will be ignored and will not affect the response.
: You can also specify `'*'`, which is a wildcard for all current and future subjects.

<%= json :broadcast_receiver_edit_subjects_fields %>

### Response

<%= headers 200 %>
<%= json :broadcast_receiver %>


## Remove subjects from a Broadcast Receiver

~~~
PUT /v2/broadcast_receivers/:id/remove_subjects
~~~

### Inputs

subjects
: *Required* **array of strings**
: The [subjects](/v2/broadcast_subjects/) this broadcast receiver should not be subscribed to. Any subjects the broadcast receiver is not already subscribed to will be ignored and will not affect the response.

<%= json :broadcast_receiver_edit_subjects_fields %>

### Response

<%= headers 200 %>
<%= json :broadcast_receiver %>


## Re-roll a Broadcast Receiver's secret

~~~
PUT /v2/broadcast_receivers/:id/reroll_secret
~~~

### Response

<%= headers 200 %>
<%= json :broadcast_receiver_secret_data %>

## Disable a Broadcast Receiver

~~~
PUT /v2/broadcast_receivers/:id/disable
~~~

### Response

<%= headers 204 %>


## Enable a Broadcast Receiver

~~~
PUT /v2/broadcast_receivers/:id/enable
~~~

### Response

<%= headers 204 %>

## Delete a Broadcast Receiver

~~~
DELETE /v2/broadcast_receivers/:id
~~~

### Response

<%= headers 204 %>