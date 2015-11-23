---
layout: v2
title: Timers
---

* TOC
{:toc}

## List all currently running or paused timers

Get all the currently running or paused timers. The running timer will be shown
first, then the paused timers. Only timers for the current user are returned.

<%= api_call :get, '/v2/timers' %>

### Parameters

Each parameter passed will filter the results, and parameters are chained
(meaning that if you search by `description` and `projects`, it will only
return the timers with that description text for those projects).

description
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
<%= json_array :timer %>

## Get a project's timer

<%= api_call :get, '/v2/projects/:project_id/timer' %>

<%= headers 200 %>
<%= json :timer %>

### Notes

If a project does not have a currently running or paused timer, then the response will return a `404` status code.

<%= headers 404 %>

## Edit a project's timer

Updates the details for a project's timer. If the timer does not exist, it will automatically be created.

<%= api_call :put, '/v2/projects/:project_id/timer' %>

<%= headers 200 %>
<%= json :timer %>

### Input

description
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

## Start a project's timer

<%= api_call :put, '/v2/projects/:project_id/timer/start' %>

<%= headers 200, :Location => "#{API_V2_URL}/projects/1/timer"  %>
<%= json :timer %>

### Input

entry_date
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: If no value is provided, the current date will be used.

description
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

### Notes

* When a timer is started, the currently running timer (if any) is paused.
* Once a timer has been started, its entry date cannot be changed with the `start` action, even if it is paused or stopped. However, you can change the entry date for the timer when the timer is logged.

## Pause a project's timer

The response does not change if the timer has already been paused or does not exist

<%= api_call :put, '/v2/projects/:project_id/timer/pause' %>

<%= headers 200 %>
<%= json :timer %>

### Notes

If a project does not have a currently running or paused timer, then the response will return a `404` status code.

<%= headers 404 %>

## Log the time in a project's timer

When a timer is logged, a new entry is created for the user with the description provided.

<%= api_call :put, '/v2/projects/:project_id/timer/log' %>

<%= headers 204 %>

### Input

entry_date
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: The date that will be used when creating an entry based on this timer. If no value is provided, then the `entry_date` provided when the timer was started will be used.

minutes
: *Optional* **integer**
: The number of minutes logged in the time entry. This number will automatically be rounded up based on the project's "billing_increment" settings. If no value is provided, then the timer's elapsed minutes will be used.

description.
: *Optional* **string**
: The description that will be used when the timer is logged. Any tags or hashtags will be automatically parsed.

### Notes

If a project does not have a currently running or paused timer, then the response will return a `404` status code.

<%= headers 404 %>

### Custom Error Codes

* **cannot_create_tags**: The authenticated user is unable to create new tags


## Discard a project's timer

When a project's timer is discarded, the timer is deleted and no time entry is recorded.

<%= api_call :delete, '/v2/projects/:project_id/timer' %>

### Response

<%= headers 204 %>
