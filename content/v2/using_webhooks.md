---
layout: v2
title: Using Webhooks
---

<div class="note warning">
 <h2>In Beta!</h2>
 <p>Webhooks and Broadcasts are in beta while we make sure they're rock solid. The specs are finalized though, so they're safe to add to your integration!</p>
</div>

* TOC
{:toc}

# How do Webhooks work?

Webhooks allow your application or integration to be notified of specific events in your Noko account. You can use this to automatically update project estimates, generate summary reports for the time logged every day, integrate your Noko invoices with your bookkeeping software; the possibilities are endless!

Rather than polling for new data or changes, you can subscribe to specific events, and we'll notify you as soon as they happen!

Once a Webhook has been created, we'll send `POST` requests for the events that you've subscribed to for that webhook.

## How do I create a Webhook?

To create a webhook, you'll need:

* A publicly accessible URI for us to send events to
* An idea of what [events](/v2/webhook_events/) you want to be notified of
* A good name for the webhook (so you don't forget what it's for!)

### Which type of setup should I choose?

[Webhooks Endpoint](/v2/webhooks/) (**Strongly recommended**)
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


## Pinging your Webhook

When your Webhook is created (either through the Webapp or from the API), we send a `webhook.ping` event, so you can verify that your webhook is receiving data from Noko.

You can also manually trigger a ping at any time, either from the Webapp (if it's a standalone webhook), or using the [Ping action in the Webhook Endpoint](/v2/webhooks/#ping-a-webhook) for API Webhooks.

A Ping event has the following structure:

<%= request_headers EXAMPLE_WEBHOOK_PING_HEADERS %>
<%= json :EXAMPLE_WEBHOOK_PING_BODY %>

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


## Webhook failures and retries

Each webhook sends its payloads serially, **and will not send future payloads if a payload fails**. We wait until the webhook responds with a successful status code before sending the next payload to help prevent state bugs and simplify the bugfixing process on your end. We want any bugs to be as easy and straightforward to fix as possible, and consistent, serialized results help with that.

We retry failed payloads for up to 3 days, using an exponential backoff algorithm to space out the retries. Because each Webhook sends its payloads serially, **a webhook will stop receiving events if it's failed to successfully process a payload after 3 days**. You can manually retry a failing payload from the Webapp (if it's a standalone Webhook) or using the [Retry action in the Webhook Endpoint](/v2/webhooks/#retry-a-webhook-payload).