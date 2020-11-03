---
layout: v2
title: Using Broadcasts
---

<div class="note warning">
 <h2>In Beta!</h2>
 <p>Webhooks and Broadcasts are in beta while we make sure they're rock solid. The specs are finalized though, so they're safe to add to your integration!</p>
</div>

* TOC
{:toc}

# What are Broadcast Receivers?

Broadcast Receivers allow your application or integration to be notified that it should call the API to get the latest version of specific parts of the API. You can use this to automatically keep [Timers](/v2/timers) in sync.

Rather than polling for new data or changes, you can subscribe to a generic subject, and we'll send any updates at a regular interval.

Once a Broadcast Receiver has been created, we'll send `POST` requests for the subjects that you want to be notified on for that receiver.

## How do I setup a Broadcast Receiver?

To create a Broadcast Receiver, you'll need:

* A publicly accessible URI for us to send events to
* An idea of what [subjects](#broadcast-subjects) you want to be notified for
* A good name for the broadcast receiver (so you don't forget what it's for!)

### Which type of setup should I choose?

[Broadcast Receiver Endpoint](/v2/broadcast_receiver/) (**Strongly recommended**)
: My application will be running in a production environment, I'm writing an integration for Noko in my project, or I want to automate setup.

[Creating a Broadcast Receiver from the Webapp](#creating-a-broadcast-receiver-from-the-webapp)
: My application is a script or for internal use only.

### Creating a Broadcast Receiver from the API

In order to create a Broadcast Receiver from the API, [you'll need to have valid API credentials](/v2/authentication). Using the API to manage your broadcast receivers allows you automatically set up your integration, without requiring a user to copy/paste any URLs, or configure anything else!

### Creating a Broadcast Receiver from the Webapp

You can create a Broadcast Receiver from the main Noko app by going to the "Broadcasts" tab in your "Integrations & Connected Apps" section.

## How are Broadcasts different than Webhooks?

Even though Broadcasts and Webhooks are similar, they solve different problems.

For certain parts of Noko's API, such as [Timers](/v2/timers), a traditional webhook is not a good fit. These parts of Noko can change rapidly, which would generate a lot of spurious updates if they were sent as webhooks.

Instead, Noko tracks the latest messages as they happen, and sends them to you at regular intervals. You can then use the message to get the latest update from Noko's API.

Rather than providing an instance of the resource after an event has occured, Broadcasts notify your application to request the latest version.

Broadcasts also do not track failures or retry messages that fail. This makes sure that you do not accidentally receive stale data, since these parts of the API can change rapidly.

### Example: Timer Syncing in a Project Management Tool

Let's say you're writing a project management tool that integrates with your Noko account.

* You want to show which Timers are running in Noko, so team members can see what you're working on. To do this, you'd create a Broadcast Receiver that is subscribed to the `timer` subject. Noko will keep track of your latest timer activities, and send them to your app using the broadcast receiver. You can use these messages, along with the API, to show which timers are running or paused.
* You also want to be able to start a timer directly from your project management tool. You would use the [API to start a timer](https://developer.nokotime.com/v2/timers/#start-a-projects-timer)

## What does a Broadcast look like?

A Broadcast has the following structure:

~~~
POST <%= EXAMPLE_BROADCAST_RECEIVER_URI %>
~~~

<%= request_headers EXAMPLE_BROADCAST_HEADERS %>
<%= json :example_broadcast_body %>

### Using the Hypermedia URL to get the latest data

Broadcasts include a [Hypermedia URL](/v2/#hypermedia) for the resource that the message is for, as part of the `subject` object. You can use this URL to get the latest version of this resource, using your [API credentials](/v2/authentication/)

## Verifying a Broadcast payload

A secret key is automatically generated when a broadcast receiver is created, **make sure you store this signature when you create your broadcast receiver!** (but you can always re-roll the signature if you need to). We use this secret to generate a signature for each broadcast, so you can verify that the request came from Noko. This signature is stored in the `X-Noko-Signature` request header.

To verify the signature:

1. Retrieve the `secret` value that you stored
2. Use a SHA 256 HMAC hexdigest to compute the hash, using the `secret` as the key.
3. Compare your generated signature with the one in `X-Noko-Signature`.

**Make sure to use a secure comparison method, like [`Rack::Utils.secure_compare`](https://www.rubydoc.info/gems/rack/Rack/Utils#secure_compare-class_method)**


## Broadcast failures and retries

**Broadcasts do not track failures or retry messages that fail.** This is to help ensure you do not accidentally receive stale data, since these resources can change rapidly.