---
layout: v2
title: Inbox Entries
---

<div class="note warning sticky">
 <h2>Not implemented yet!</h2>
 <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List Inbox Entries

Get all inbox entries for the authenticated user, sorted by the most recent inbox entry date.

~~~
GET /v2/inbox_entries
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `description` and `project_name`, it will only return inbox entries with the given project name and description).

description
: *Optional* **string**
: Only inbox entries containing this text in their description are returned.
: Example: `description=meeting`

project_name
: *Optional* **string**
: Only inbox entries containing this text in their project name are returned.
: Example: `name=Gear`

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only inbox entries from or after this date will be returned.
: Example: `from=2013-09-27`

to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only inbox entries on or before this date will be returned.
: Example: `to=2013-09-27`

logged
: *Optional* **boolean**
: `true`: only show logged inbox entries
: `false`: only shows unlogged inbox entries

updated_from
: *Optional* **string** of a timestamp in ISO 8061 format `YYYY-MM-DDTHH:MM:SSZ`
: Only inbox entries updated from or after this timestamp will be returned.
: Example: `updated_from=2012-01-09T08:33:29Z`

updated_to
: *Optional* **string** of a timestamp in ISO 8061 format `YYYY-MM-DDTHH:MM:SSZ`
: Only inbox entries updated on or before this timestamp will be returned.
: Example: `updated_to=2012-01-09T08:33:29Z`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "inbox_entries" %>
<%= json_array :inbox_entry %>

## Get a single Inbox Entry

~~~
GET /v2/inbox_entries/:id
~~~

<%= headers 200 %>
<%= json :inbox_entry %>

## Create an Inbox Entry

~~~
POST /v2/inbox_entries
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: The date of the inbox entry.

description
: *Required* **string**
: The description of the inbox entry.

minutes
: *Optional* **integer**
: The number of minutes logged in this inbox entry.

project_name
: *Optional* **string**
: The project name this inbox entry is prefilled with.

<%= json :inbox_entry_editable_fields %>

### Reponse

<%= headers 201, :Location => "#{API_V2_URL}/inbox_entries/1" %>
<%= json :inbox_entry %>

## Edit an Inbox Entry

~~~
PUT /v2/inbox_entries/:id
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: The date of the inbox entry.

description
: *Required* **string**
: The description of the inbox entry.

minutes
: *Optional* **integer**
: The number of minutes logged in this inbox entry.

project_name
: *Optional* **string**
: The project name this inbox entry is prefilled with.

<%= json :inbox_entry_editable_fields %>

### Response

<%= headers 200 %>
<%= json :inbox_entry %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **logged**: the Inbox Entry has been logged and cannot be updated

## Log an Inbox Entry

~~~
POST /v2/inbox_entries/:id/log
~~~

### Parameters

Use the parameters specified in the [Entry API's Create Action](/v2/entries/index.html#create-an-entry) to log the entry.

### Response

<%= headers 201, :Location => "#{API_V2_URL}/entries/1" %>
<%= json :entry %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **logged**: the Inbox Entry has already been logged

## Delete an Inbox Entry

~~~
DELETE /v2/inbox_entries/:id
~~~

### Response

<%= headers 204 %>

### A note about inbox entry deletion

An inbox entry cannot be deleted if it has been logged.

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **logged**: the Inbox Entry has been logged