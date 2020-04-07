---
layout: v2
title: Webhooks
---


<div class="note warning sticky">
   <h2>Not implemented yet!</h2>
   <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
 </div>

* TOC
{:toc}

# How do Webhooks work?

Webhooks allow your application or integration to be notified of specific events in your Noko account. You can use this to automatically update project estimates, generate summary reports for the time logged every day, integrate your Noko invoices with your bookkeeping software; the possibilities are endless!

Rather than polling for new data or changes, you can subscribe to specific events, and we'll notify you as soon as they happen!

Once a Webhook has been created, we'll send `POST` requests for the events that you've subscribed to for that webhook.

## How do I create a Webhook?

<div class="note warning">
 <h2>Supervisor access required</h2>
 <p>In the current version of Webhooks, you will need supervisor access to Noko in order to use webhooks. This will likely change in the future 😊</p>
</div>

To create a webhook, you'll need:

* A publicly accessible URI for us to send events to
* An idea of what [events](/v2/webhook_events/) you want to be notified of
* A good name for the webhook (so you don't forget what it's for!)

### Which type of setup should I choose?

[Webhooks Endpoint](#creating-a-webhook) (**Strongly recommended**)
: My application will be running in a production environment, I'm writing an integration for Noko in my project, or I want to automate setup.

[Creating a webhook from the Webapp](#creating-a-webhook-from-the-webapp)
: My application is a script or for internal use only.

### Creating a Webhook from the API

In order to create a Webhook from the API, [you'll need to have valid API credentials](/v2/authentication). Using the API to manage your webhooks allows you automatically set up your integration, without requiring a user to copy/paste any URLs, or configure anything else!

### Creating a Webhook from the Webapp

You can create a Webhook from the main Noko app by going to the "Webhooks" tab in your "Integrations & Connected Apps" section.

## How are Webhooks different than the API?

Webhooks are a way to be **notified** of changes in your Noko account, while the API is a way to **access and interact** with your Noko account.

When a Webhook is notified of an event, it will receive an `object` that matches the way the resource is given in the API. This is so you can reuse the same code between your Webhooks & API actions.

Oftentimes, an integration will use both Webhooks & the API to connect with Noko.

### Example: Project Management Tool

Let's say you have a project management tool that integrates with your Noko account.

* You want to update your dashboards in real-time, as people log their time in Noko. To do this, you'd create a Webhook that listens to the `entry` events, and your webhook would update your dashboards
* As soon as a project is created in your project managent tool, you want to immediately create the project in Noko so your team can log time against it. You would use the [API to create a new project](/v2/projects/#create-a-project)

## What does a Webhook payload look like?

A Webhook payload has the following structure:

~~~
POST <%= EXAMPLE_WEBHOOK_PAYLOAD_URI %>
~~~

<%= request_headers EXAMPLE_WEBHOOK_PAYLOAD_HEADERS %>
<%= json :example_webhook_payload_body %>


## Verifying a Webhook payload

A secret key is automatically generated when a webhook is created, **make sure you store this signature when you create your webhook!** (but you can always re-roll the signature if you need to). We use this secret to generate a signature for each webhook payload, so you can verify that the request came from Noko. This signature is stored in the `X-Noko-Signature` request header.

To verify the signature:

1. Retrieve the `secret` value that you stored
2. Use a SHA 256 HMAC hexdigest to compute the hash, using the `secret` as the key.
3. Compare your generated signature with the one in `X-Noko-Signature`.

**Make sure to use a secure comparison method, like [`Rack::Utils.secure_compare`](https://www.rubydoc.info/gems/rack/Rack/Utils#secure_compare-class_method)**


# The Webhooks API

This API allows you to manage your webhooks entirely from the API, so you can set up your integrations automatically without requiring any user configuration.

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
: A comma-separated list of [events](/v2/webhook_events/) to filter by. Accepted values are:
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

payload_url
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
: *Required* **string**
: The name of the Webhook

payload_url
: *Required* **string**
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

## Delete a Webhook

~~~
DELETE /v2/webhooks/:id
~~~

### Response

<%= headers 204 %>