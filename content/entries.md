---
layout: default
title: Entry
---

## List Entries

Get all the entries, sorted by the most recent entry date.

~~~
GET /entries/
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `users` and `projects`, it will only return entries from those users for the specified projects).

users
: *Optional* **string**: a comma-separated list of user IDs to filter by.
Example: `users=1,2,3`

descripton
: *Optional* **string**: Only entries containing this text in their description are returned.

projects
: *Optional* **string**: a comma-separated list of project IDs to filter by.
Example: `projects=4,5,6`

tags
: *Optional* **string**: a comma-separated list of tags to filter by.

tag_filter_type
: *Optional* **string**: an indicator of how to filter by tags. Accepted values are: `and`, `any`. Defaults to: `and`

invoices
: *Optional* **string**: a comma-separated list of invoices to filter by

imports
: *Optional* **string**: a comma-separated list of imports to filter by

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only entries from or after this date will be returned.

to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only entries on or before this date will be returned.

invoiced_at_from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only entries invoiced from or after this date will be returned.

invoiced_at_to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only entries invoiced on or before this date will be returned.

billable
: *Optional* **boolean**: `true` only shows billable entries, `false` only shows unbillable entries

### Response

<%= headers 200, :pagination => true, :pagination_resource => "entries" %>
<%= json :entry %>

## Get a single Entry

~~~
GET /entries/:id
~~~

<%= headers 200 %>
<%= json :entry %>

## Create an Entry

~~~
POST /entries/
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the time entry.

user
: *Optional* **integer**: The ID of the user who logged this time entry. If no value is provided, the authenticated user will be used.

minutes
: *Required* **integer**: The number of minutes logged in this time entry. This number will automatically be rounded up based on the project's "stepping" settings.

description
: *Optional* **string**: The description of the time entry. Any tags or hashtags will be automatically parsed.

project
: *Optional* **integer**: The ID of the project this time entry is logged under. If no value is provided, this time entry will not be logged under any project.

source_url
: *Optional* **string**: a URL that corresponds to the work completed in this time entry. An good example is a URL to a commit when [integrating with Github or Beanstalk](http://help.letsfreckle.com/import-export-api/log-time-from-commit-messages).

<%= json :entry_editable_fields %>

### Reponse

<%= headers 201, :Location => "https://apitest.letsfreckle.com/api/v2/entries/1" %>
<%= json :entry %>

## Edit an Entry

~~~
PATCH /entry/:id
~~~

### Input

date
: *Optional* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the time entry.

user
: *Optional* **integer**: The ID of the user who logged this time entry. If no value is provided, the authenticated user will be used.

minutes
: *Optional* **integer**: The number of minutes logged in this time entry. This number will automatically be rounded up based on the project's "stepping" settings.

description
: *Optional* **string**: The description of the time entry. Any tags or hashtags will be automatically parsed.

project
: *Optional* **integer**: The ID of the project this time entry is logged under. If no value is provided, this time entry will not be logged under any project.

source_url
: *Optional* **string**: a URL that corresponds to the work completed in this time entry. An good example is a URL to a commit when [integrating with Github or Beanstalk](http://help.letsfreckle.com/import-export-api/log-time-from-commit-messages).

<%= json :entry_editable_fields %>

### Response

<%= headers 200 %>
<%= json :entry %>

## Mark Entry as invoiced outside of Freckle

~~~
PUT /entries/:id/invoiced_outside_of_freckle
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`: the date the time entry was invoiced outside of Freckle.

### Response

<%= headers 204 %>

## Mark multiple Entries as invoiced outside of Freckle

~~~
PUT /entries/invoiced_outside_of_freckle
~~~

### Input

entries
: *Required* **array of integers**: the IDs of the entries that will be marked as invoiced outside of Freckle.

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`: the date the time entry was invoiced outside of Freckle.

### Response

<%= headers 204 %>

## Delete an Entry

~~~
DELETE /entries/:id
~~~

### Response

<%= headers 204 %>

### A note about entry deletion

An entry cannot be deleted if it has been invoiced or is associated with an archived project. In this case, response will include detailed information about why the entry couldn't be deleted.

There are two error codes that will be used to indicate why the entry could not be deleted:

* **invoiced**
* **archived_project**