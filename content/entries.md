---
layout: default
title: Entry
---

* TOC
{:toc}

## List Entries

Get all entries, sorted by the most recent entry date.

~~~
GET /entries/
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `users` and `projects`, it will only return entries from those users for those projects).

users
: *Optional* **string**
: A comma-separated list of user IDs to filter by.
: Example: `users=1,2,3`

descripton
: *Optional* **string**
: Only entries containing this text in their description are returned.
: Example: `description=meeting`

projects
: *Optional* **string**
: A comma-separated list of project IDs to filter by.
: Example: `projects=4,5,6`

tags
: *Optional* **string**
: A comma-separated list of tags to filter by.
: Example: `tags=7,8,9`

tag_filter_type
: *Optional* **string**
: Indicates how to filter by tags.
: Accepted values: `and` (**default**), `any`

invoices
: *Optional* **string**
: A comma-separated list of invoice IDs to filter by.
: Example: `invoices=1,2,3`

imports
: *Optional* **string**
: A comma-separated list of import IDs to filter by.
: Example: `imports=4,5,6`

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only entries from or after this date will be returned.
: Example: `from=2013-09-27`

to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only entries on or before this date will be returned.
: Example: `to=2013-09-27`

invoiced_at_from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only entries invoiced from or after this date will be returned.
: Example: `invoiced_at_from=2013-09-27`

invoiced_at_to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only entries invoiced on or before this date will be returned.
: Example: `invoiced_at_to=2013-09-27`

billable
: *Optional* **boolean**
: `true`: only show billable entries
: `false`: only shows unbillable entries

### Response

<%= headers 200, :pagination => true, :pagination_resource => "entries" %>
<%= json_array :entry %>

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
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`
: The date of the time entry.

user_id
: *Optional* **integer**
: The ID of the user who logged this time entry. If no value is provided, the authenticated user will be used.

minutes
: *Required* **integer**
: The number of minutes logged in this time entry. This number will automatically be rounded up based on the project's "stepping" settings.

description
: *Optional* **string**
: The description of the time entry. Any tags or hashtags will be automatically parsed.

project_id
: *Optional* **integer**
: The ID of the project this time entry is logged under. If no value is provided, this time entry will not be logged under any project.

project_name
: *Optional* **string**
: The name of the project this time entry is logged under. If no value is provided, this time entry will not be logged under any project.
: This value is only used if no value is provided for `project_id`.
: If a project with this name does not exist yet, it will automatically be created with this entry.

source_url
: *Optional* **string**
: A URL that corresponds to the work completed in this time entry. Some Examples Include:
: * the URL to a commit in a version control platform like [Github or Beanstalk](http://help.letsfreckle.com/import-export-api/log-time-from-commit-messages)
: * the URL to a specific task in a project management app like [Planscope](https://planscope.io/) or [Basecamp](https://planscope.io/)
: * the URL to a client's website.

<%= json :entry_editable_fields %>

### Reponse

<%= headers 201, :Location => "https://apitest.letsfreckle.com/api/v2/entries/1" %>
<%= json :entry %>


### Custom Error Codes

* **reached_project_limit**: The account has reached its project limit, so no more projects can be created until the account has been upgraded.
* **cannot_create_projects**: The authenticated user is unable to create projects.
* **user_cannot_access_project**: the entry's user does not have access to the referenced project.

## Edit an Entry

~~~
PATCH /entry/:id
~~~

### Input

date
: *Optional* **string** of a date in ISO 8061 format `YYY-MM-DD`
: the date of the time entry.

user_id
: *Optional* **integer**
: The ID of the user who logged this time entry. If no value is provided, the user will not be changed.

minutes
: *Optional* **integer**
: The number of minutes logged in this time entry. This number will automatically be rounded up based on the project's "stepping" settings. If no value is provided, then the entry will have `0` minutes.

description
: *Optional* **string**
: The description of the time entry. Any tags or hashtags will be automatically parsed.

project_id
: *Optional* **integer**
: The ID of the project this time entry is logged under. If no value is provided, the project will not be changed.

project_name
: *Optional* **string**
: The name of the project this time entry is logged under. If no value is provided, the project will not be changed.
: This value is only used if no value is provided for `project_id`.
: If a project with this name does not exist yet, it will automatically be created with this entry.

source_url
: *Optional* **string**
: A URL that corresponds to the work completed in this time entry. Some Examples Include:
: * the URL to a commit in a version control platform like [Github or Beanstalk](http://help.letsfreckle.com/import-export-api/log-time-from-commit-messages)
: * the URL to a specific task in a project management app like [Planscope](https://planscope.io/) or [Basecamp](https://planscope.io/)
: * the URL to a client's website.

<%= json :entry_editable_fields %>

### Response

<%= headers 200 %>
<%= json :entry %>

### Custom Error Codes

* **reached_project_limit**: The account has reached its project limit, so no more projects can be created until the account has been upgraded.
* **cannot_create_projects**: The authenticated user is unable to create projects.
* **user_cannot_access_project**: the entry's user does not have access to the referenced project.

## Mark Entry as invoiced outside of Freckle

Update the Entry so that is recognized as being invoiced outside of Freckle by providing the date the Entry was invoiced.

If the entry has already been marked as invoiced outside of freckle, this action modifies the `invoiced_at` date for the entry.

~~~
PUT /entries/:id/invoiced_outside_of_freckle
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: The date the time entry was invoiced outside of Freckle.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **already_invoiced**: the Entry has already been invoiced inside of Freckle.

## Mark multiple Entries as invoiced outside of Freckle

Update the Entries provided so that they are recognized as being invoiced outside of Freckle by providing the date the Entries was invoiced.

If an entry has already been marked as invoiced outside of Freckle, this action modifies the `invoiced_at` date for that entry.

~~~
PUT /entries/invoiced_outside_of_freckle
~~~

### Input

entries
: *Required* **array of integers**
: The IDs of the entries that will be marked as invoiced outside of Freckle.

date
: *Required* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: The date the time entry was invoiced outside of Freckle.

### Response

<%= headers 204 %>

### A note about Entries that cannot be marked as invoiced outside of Freckle

Any entries that are included in this request that cannot be marked as invoiced outside of Freckle will be ignored and will not affect the Response.

## Delete an Entry

~~~
DELETE /entries/:id
~~~

### Response

<%= headers 204 %>

### A note about entry deletion

An entry cannot be deleted if it has been invoiced or is associated with an archived project. In this case, response will include detailed information about why the entry couldn't be deleted.

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invoiced**: the Entry has been invoiced
* **archived_project**: the Entry is associated with an archived Project