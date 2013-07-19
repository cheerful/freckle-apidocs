---
layout: default
title: Project Group
---

# Project Group API

## Project Group Object Specification

<%= json :project_group %>

## List Project Groups

~~~
GET /project_groups/
~~~

### Parameters

name
: *Optional* **string**: Only Project Groups containing this string in their name will be returned

projects
: *Optional* **array of integers**: a comma-separated list of project IDs to filter by.

participants
: *Optional* **array of integers**: a comma-separated list of user IDs to filter by.

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

projects
: *Optional* **array of integers**: a comma-separated list of project IDs to add to the project group.

<%= json :project_group_create_fields %>

### Response

<%= headers 200 %>
<%= json :project_group %>

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

## Get the entries for projects in a project group

~~~
GET /project_groups/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/entries" %>
<%= json :entry %>

## List Invoices for projects in a project group

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
: *Required* **array of integers**: the IDs of each project to add to the project group.

### Response

<%= headers 200 %>
<%= json :project %>

## Remove a Project from Group

~~~
PUT /imports/:id/projects
~~~

### Input

projects
: *Required* **array of integers**: the IDs of each project to remove from the project group.

### Response

<%= headers 204 %>

## Remove all Projects from a Project Group

~~~
DELETE /imports/:id/projects/
~~~

### Response

<%= headers 204 %>

## Delete a Project Group

~~~
DELETE /project_groups/:id/
~~~

### Response

<%= headers 204 %>