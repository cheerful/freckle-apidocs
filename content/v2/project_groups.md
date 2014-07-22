---
layout: default
title: Project Group
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List Project Groups

~~~
GET /project_groups/
~~~

### Parameters

name
: *Optional* **string**
: Only Project Groups containing this string in their name will be returned.
: Example: `name=Sprockets`

projects
: *Optional* **string**
: A comma-separated list of project IDs to filter by.
: Example: `projects=1,2,3`

participants
: *Optional* **string**
: A comma-separated list of user IDs to filter by.
: Example: `participants=4,5,6`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups" %>
<%= json :project_group %>


## Create a Project Group

~~~
POST /project_groups/
~~~

### Inputs

name
: *Required* **string**
: The name of the Project Group.

projects
: *Required* **array of integers**
: The IDs of the Projects to include in this Project Group.

<%= json :project_group_create_fields %>

### Response

<%= headers 200 %>
<%= json :project_group %>

### If one of the Projects is already associated with a Project Group

If any of the Projects provided are already associated with another group Project Group, a `422` error will be returned:

<%= headers 422 %>
<%= json :validation_error_project_already_associated_with_a_group %>

## Get a Project Group

~~~
GET /project_groups/:id
~~~

### Response

<%= headers 200 %>
<%= json :project_group %>

## Edit a Project Group

~~~
PUT /project_groups/:id/
~~~

### Inputs

name
: *Optional* **string**

<%= json :project_group_edit_fields %>

### Response

<%= headers 200 %>
<%= json :project %>

## Get the entries for projects in a project_group

~~~
GET /project_groups/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/entries" %>
<%= json :entry %>

## List Invoices for projects in a project_group

~~~
GET /project_groups/:id/invoices
~~~

### Parameters

You can use the parameters specified in the [Invoice API's List Action](/invoices/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/invoices" %>
<%= json :invoice %>

## List participants in a Project Group

~~~
GET /imports/:id/participants
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/participants" %>
<%= json :user %>

## Add a Project to a Project Group

~~~
POST /imports/:id/projects
~~~

### Input

projects
: *Required* **array of integers**
: The IDs of the Projects to add to the Project Group. Any Projects that are already associated with another Project Group will be ignored and will not affect the Response.

### Response

<%= headers 200 %>
<%= json :project %>

## Remove a Project from Project Group

~~~
PUT /imports/:id/projects
~~~

### Input

projects
: *Required* **array of integers**
: The IDs of the Projects to remove from the Project Group. Any Projects that are not associated with the Project Group will be ignored and will not affect the Response.

### Response

<%= headers 204 %>

## Remove all Projects from a Project Group

~~~
DELETE /imports/:id/projects/
~~~

### Response

<%= headers 204 %>

## Delete a Project Group

When a Project Group is deleted, the Project in the Project Group **are not** deleted. Instead, they are not associated with any project Project Group.

~~~
DELETE /project_groups/:id/
~~~

### Response

<%= headers 204 %>