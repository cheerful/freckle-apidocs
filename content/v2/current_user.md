---
layout: default
title: Current User
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## Get the Current User

~~~
GET /current_user/
~~~

### Response

<%= headers 200 %>
<%= json :current_user %>

## Get the Current User's Entries

~~~
GET /current_user/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/entries" %>
<%= json :entry %>

## Get the Current User's Expenses

~~~
GET /current_user/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/expenses" %>
<%= json :expense %>

## Edit the Current User

~~~
PUT /current_user
~~~

### Inputs

first name
: *Optional* **string**: the first name of the user

last name
: *Optional* **string**: the last name of the user

time_format
: *Optional* **string**: How time should be formatted. Accepted values are:

    * fraction
    * hours_minutes

week_start
: *Optional* **string**: when the week starts for the current user. Accepted Values are:

    * sunday
    * monday

send_personal_weekly_report
: *Optional* **boolean**: indicates whether a personal weekly report email should be sent.

send_team_weekly_report
: *Optional* **boolean**: indicates whether a team weekly report should be sent. If the current user is not an admin, this field will be ignored.

### Response

<%= headers 200 %>
<%= json :current_user %>

