---
layout: default
title: Project
---

## List Projects

List all projects the authenticated user has access to

~~~
GET /projects/
~~~

### Parameters

name
: *Optional* **string**

stepping
: *Optional* **integer**: projects with a specific rounding value.

enabled
: *Optional* **boolean**: `true` returns all enabled projects, `false` returns all disabled projects

billable
: *Optional* **boolean**: `true` returns all billable tags, `false` returns all unbillable tags.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects" %>
<%= json :project %>

## Get a single project

~~~
GET /projects/:id
~~~

### Response

<%= headers 200 %>
<%= json :project %>

## Create a Project

~~~
POST /projects/
~~~

### Inputs

name
: *Required* **string**: The name of the project

group
: *Optional* **integer**: The ID of the group this project is assigned under. Defaults to 15

color_hex
: *Optional* **string**: a hexadecimal color code for the project

project_goals
: *Optional* **array of objects**: the project goals to create for this project. The fields are:

	budgeted_minutes
	: *Required* **integer**: the number of minutes to budget for this goal

	starts_on
	: *Required* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal starts.

	ends_on
	: *Required* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal ends.

	renews
	: *Optional* **string**: how the goal renews. Supported values are:

		* `none` (**default**)
		* `yearly`
    * `quarterly`
    * `monthly`
    * `weekly-sunday`
    * `weekly-monday`
    * `daily`

### Response

<%= headers 200 %>
<%= json :project %>

## Edit a Project

~~~
PATCH /projects/:id
~~~

### Inputs

name
: *Required* **string**: The name of the project

group
: *Optional* **integer**: The ID of the group this project is assigned under. Defaults to 15

color_hex
: *Optional* **string**: a hexadecimal color code for the project

### Response

<%= headers 200 %>
<%= json :project %>

## Add goals to a project

~~~
POST /projects/:id/goals
~~~

### Inputs

project_goals
: *Optional* **array of objects**: the project goals to create for this project. The fields are:

	budgeted_minutes
	: *Required* **integer**: the number of minutes to budget for this goal

	starts_on
	: *Required* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal starts.

	ends_on
	: *Required* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal ends.

	renews
	: *Optional* **string**: how the goal renews. Supported values are:

		* `none` (**default**)
		* `yearly`
    * `quarterly`
    * `monthly`
    * `weekly-sunday`
    * `weekly-monday`
    * `daily`

## Update a project's goal

~~~
PATCH /projects/:id/goals/:id
~~~

### Inputs

budgeted_minutes
: *Optional* **integer**: the number of minutes to budget for this goal

starts_on
: *Optional* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal starts.

ends_on
: *Optional* **string in the format of ISO 8061 date format `YYYY-MM-DD`: when the goal ends.

renews
: *Optional* **string**: how the goal renews. Supported values are:

	* `none`
	* `yearly`
  * `quarterly`
  * `monthly`
  * `weekly-sunday`
  * `weekly-monday`
  * `daily`

### Response

<%= headers 200 %>
<%= json :project %>

## Remove a goal from a project

~~~
DELETE /projects/:id/goals/:id
~~~

### Response

<%= headers 204 %>

## Remove all Goals from a Project

~~~
DELETE /projects/:id/goals
~~~

### Response

<%= headers 204 %>

## Get the entries for a project

~~~
GET /projects/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/entries" %>
<%= json :entry %>

## List the Invoices for a project

~~~
GET /projects/:id/invoices
~~~

### Parameters

You can use the parameters specified in the [Invoice API's List Action](/invoices/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/invoices" %>
<%= json :invoice %>

## List The participants in a Project

~~~
GET /projects/:id/participants
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/participants" %>
<%= json :user %>

## Merge a Project into this project

~~~
PUT /projects/:id/merge
~~~

### Inputs

project
: *Required* **integer**: the ID of the project to merge into this project

### Response

<%= headers 204 %>

## Delete a Project

~~~
DELETE /projects/:id
~~~

### Response

<%= headers 204 %>

### A note about project deletion

A project cannot be deleted if there are any entries, invoices, or expenses associated with this project.

You can archive the project, which will flag the project as "archived" while keeping any entries, invoices, or expenses associated with this project.

For more information about how deleting and archiving a project works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)

## Archive a Project

~~~
PUT /projects/:id/archive
~~~

### Response

<%= headers 204 %>

### A note about project archiving

A project cannot be archived if there are no entries, invoices, or expenses associated with this project. Instead, you can only delete the project.

For more information about how deleting and archiving a project works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)

## Archive multiple Projects at once

~~~
PUT /projects/archive
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to be archived

### Response

<%= headers 204 %>

### A note about projects that cannot be archived

Any projects are included in this request that cannot be archived will be ignored and will not affect the Response.