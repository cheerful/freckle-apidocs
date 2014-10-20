---
layout: default
title: Project
---

<div class="note warning sticky">
  <h2>Almost finished!</h2>
  <p>This resource is almost finished, but the following actions will return a 404 error:</p>
  <ul>
    <li><a href="#get-the-invoices-for-a-project">Get the Invoices for a project</a></li>
    <li><a href="#get-the-participants-in-a-project">Get The participants in a Project</a></li>
  </ul>
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
: Only projects containing this text in their name are returned.
: Example: `name=Gear`

project_group_ids
: *Optional* **string**: a comma-separated list of Project Group IDs to filter by.
: Example: `project_group_ids=1,2,3`

billing_increment
: *Optional* **integer**
: Only projects with this specific billing increment are returned
: Example: `stepping=15`
: Accepted values: `1`, `5`, `6`, `10`, `15` (**Default**), `20`, `30`, `60`

enabled
: *Optional* **boolean**
: `true`: return all enabled projects
: `false` returns all archived projects

billable
: *Optional* **boolean**
: `true`: return all billable projects
: `false` return all unbillable projects.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects" %>
<%= json_array :project %>

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

billable
: *Optional* **boolean**
: Whether the project is billable or unbillable. Defaults to `true`

project_group_id
: *Optional* **integer**
: The ID of the Project Group the project will be associated with.

billing_increment
: *Optional* **integer**
: The billing increment used by this project.
: Accepted values: `1`, `5`, `6`, `10`, `15` (**Default**), `20`, `30`, `60`

color_hex
: *Optional* **string**
: The hexadecimal color code that will be used as the project's color.

<%= json :project_create_fields %>

### Response

<%= headers 200 %>
<%= json :project %>

### Custom Error Codes

* **reached_project_limit**: The account has reached its project limit, so no more projects can be created until the account has been upgraded.

## Get the entries for a project

~~~
GET /projects/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/entries" %>
<%= json_array :entry %>

## Get the Invoices for a project

~~~
GET /projects/:id/invoices
~~~

### Parameters

You can use the parameters specified in the [Invoice API's List Action](/invoices/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/invoices" %>
<%= json_array :invoice %>

## Get The participants in a Project

~~~
GET /projects/:id/participants
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "projects/:id/participants" %>
<%= json_array :user %>


## Edit a Project

~~~
PATCH /projects/:id
~~~

### Inputs

name
: *Optional* **string**
: The name of the project

project_group_id
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

<%= json :project_create_fields %>

### Custom Error Codes

* **archived_project**: the project has been archived

## Merge a Project into this project

Merge the project specified in the request body into this project. This will move all the project's entries, expenses, and invoices into this project. The project will be deleted after the merge has completed. Note that projects cannot be merged if either project is archived.  **This action is permanent**, so you cannot undo after you merge projects.

~~~
PUT /projects/:id/merge
~~~

### Inputs

project_id
: *Required* **integer**
: the ID of the Project to merge into this project.

![A diagram explaining the project merge action.](/assets/v2/project-merging-diagram.png)

### Response

<%= headers 204 %>

### Custom Error Codes

* **archived_project**: the project has been archived

## Delete a Project

~~~
DELETE /projects/:id
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

* **archived_project**: the project has been archived
* **not_deletable**: the project cannot be deleted because it has entries, expenses, or invoices

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

### Custom Error Codes

* **deletable**: the project should be deleted because it does not have any entries, expenses, or invoices

### A note about project archiving

A project cannot be archived if there are no entries, invoices, or expenses associated with this project. Instead, you can only delete the project.

For more information about how deleting and archiving a project works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)

## Unarchive a Project

~~~
PUT /projects/:id/unarchive
~~~

### Response

<%= headers 204 %>

## Archive multiple Projects at once

~~~
PUT /projects/archive
~~~

### Inputs

project_ids
: *Required* **array of integers**: the IDs of the projects to be archived

### Response

<%= headers 204 %>

### A note about projects that cannot be archived

Any projects are included in this request that cannot be archived will be ignored and will not affect the Response.

## Unarchive multiple Projects at once

~~~
PUT /projects/unarchive
~~~

### Inputs

project_ids
: *Required* **array of integers**: the IDs of the projects to be unarchived

### Response

<%= headers 204 %>

## Delete multiple Projects at once

~~~
PUT /projects/delete
~~~

### Inputs

project_ids
: *Required* **array of integers**: the IDs of the projects to be deleted

### Response

<%= headers 204 %>

### A note about projects that cannot be deleted

Any projects are included in this request that cannot be deleted will be ignored and will not affect the Response.