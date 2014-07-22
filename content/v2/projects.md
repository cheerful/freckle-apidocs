---
layout: default
title: Project
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List Projects

List all projects the authenticated user has access to

~~~
GET /projects/
~~~

### Parameters

name
: *Optional* **string**
: Example: `name=Gear`

stepping
: *Optional* **integer**
: projects with a specific rounding value.
: Example: `stepping=15`

enabled
: *Optional* **boolean**
: `true`: return all enabled projects
: `false` returns all disabled projects

billable
: *Optional* **boolean**
: `true`: return all billable tags
: `false` return all unbillable tags.

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
: *Required* **string**
: The name of the project

project_group
: *Optional* **integer**
: The ID of the Project Group the project will be associated with.

stepping
: *Optional* **integer**
: The billing increment used by this project. Defaults to 15

color_hex
: *Optional* **string**
: a hexadecimal color code for the project.


### Response

<%= headers 200 %>
<%= json :project %>

## Get the entries for a project

~~~
GET /projects/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/entries" %>
<%= json :entry %>

## Get the Invoices for a project

~~~
GET /projects/:id/invoices
~~~

### Parameters

You can use the parameters specified in the [Invoice API's List Action](/invoices/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/invoices" %>
<%= json :invoice %>

## Get The participants in a Project

~~~
GET /projects/:id/participants
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/participants" %>
<%= json :user %>


## Edit a Project

~~~
PATCH /projects/:id
~~~

### Inputs

name
: *Required* **string**
: The name of the project

project_group
: *Optional* **integer**
: The ID of the Project Group the project will be associated with.

stepping
: *Optional* **integer**
: The billing increment used by this project. Defaults to 15

color_hex
: *Optional* **string**
: a hexadecimal color code for the project.

### Response

<%= headers 200 %>
<%= json :project %>

## Merge a Project into this project

When a project is merged, all of its entries, expenses, and invoices are moved into this project. The original projects will be deleted. Note that projects cannot be merged into this project if this project is archived.  **This action is permanent**, so you cannot undo after you merge projects.

~~~
PUT /projects/:id/merge
~~~

### Inputs

project
: *Required* **integer**
: the ID of the Project to merge into this project.

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

## Delete multiple Projects at once

~~~
DELETE /projects
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to be deleted

### Response

<%= headers 204 %>

### A note about projects that cannot be deleted

Any projects are included in this request that cannot be deleted will be ignored and will not affect the Response.