---
layout: default
title: Timer
---

## List all currently running or paused Timers

Get all the currently running or paused Timers. The running Timer will be shown first, then the paused timers

~~~
GET /timers/
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `description` and `projects`, it will only return the timers with that description text for those projects).

descripton
: *Optional* **string**
: Only timers containing this text in their description are returned.
: Example: `description=meeting`

projects
: *Optional* **string**
: A comma-separated list of project IDs to filter by.
: Example: `projects=4,5,6`

billable
: *Optional* **boolean**
: `true`: only show timers for billable projects
: `false`: only show timers for unbillable projects

### Response

<%= headers 200, :pagination => true, :pagination_resource => "timers" %>
<%= json :timer %>

## Get a project's timer

~~~
GET /projects/:project_id/timer
~~~

<%= headers 200 %>
<%= json :timer %>

### A note about Getting a project's timer

If the project does not have a currently running or paused timer, then the response will return a `404` status code.

<%= headers 404 %>

## Edit a project's timer

Updates the details for a project's timer. If the timer does not exist, it will automatically be created.

~~~
PATCH /projects/:project_id/start
~~~

<%= headers 200 %>
<%= json :timer %>

## Input

description
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

## Start a project's timer

~~~
PUT /projects/:project_id/timer/start
~~~

<%= headers 201 %>
<%= json :timer %>

## Input

description
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

### A note about starting a timer when another time is already running

When a timer is started, the currently running timer is paused.

### A note about restarting a paused or stopped timer

When starting a timer that has been paused or stopped, the entry date will not change. The entry date for a timer that has already been started can be changed when the timer is logged.

## Pause a project's timer

The response does not change if the timer has already been paused or does not exist

~~~
PUT /projects/:project_id/timer/pause
~~~

<%= headers 200 %>
<%= json :timer %>

## Log the time in a project's timer

When a timer is logged, a new entry is created for the user with the description provided.


~~~
PUT /projects/:project_id/timer/log
~~~

<%= headers 204 %>

## Input

description
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

### A note about logging a timer that isn't paused or currently running

If the timer is not currently running or paused the response code will be `404`

<%= headers 404 %>


## Discard a project's timer

When a project's timer is discarded, the timer is deleted and no time entry is recorded.

~~~
DELETE /projects/:project_id/timer/
~~~

### Response

<%= headers 204 %>