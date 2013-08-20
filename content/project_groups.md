---
layout: default
title: Group
---

# Group API

## Group Object Specification

<%= json :group %>

## List Groups

~~~
GET /groups/
~~~

### Parameters

name
: *Optional* **string**: Only Groups containing this string in their name will be returned

projects
: *Optional* **array of integers**: a comma-separated list of project IDs to filter by.

participants
: *Optional* **array of integers**: a comma-separated list of user IDs to filter by.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "groups" %>
<%= json :group %>


## Create a Group

~~~
POST /groups/
~~~

### Inputs

name
: *Required* **string**

projects
: *Optional* **array of integers**: a comma-separated list of project IDs to add to the group.

<%= json :group_create_fields %>

### Response

<%= headers 200 %>
<%= json :group %>

## Get a Group

~~~
GET /groups/:id
~~~

### Response

<%= headers 200 %>
<%= json :group %>

## Edit a Group

~~~
PUT /groups/:id/
~~~

### Inputs

name
: *Optional* **string**

<%= json :group_edit_fields %>

### Response

<%= headers 200 %>
<%= json :project %>

## Get the entries for projects in a group

~~~
GET /groups/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "groups/:id/entries" %>
<%= json :entry %>

## List Invoices for projects in a group

~~~
GET /groups/:id/invoices
~~~

### Parameters

You can use the parameters specified in the [Invoice API's List Action](/invoices/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "groups/:id/invoices" %>
<%= json :invoice %>

## List participants in a Group

~~~
GET /imports/:id/participants
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "groups/:id/participants" %>
<%= json :user %>

## Add a Project to a Group

~~~
POST /imports/:id/projects
~~~

### Input

projects
: *Required* **array of integers**: the IDs of each project to add to the group.

### Response

<%= headers 200 %>
<%= json :project %>

## Remove a Project from Group

~~~
PUT /imports/:id/projects
~~~

### Input

projects
: *Required* **array of integers**: the IDs of each project to remove from the group.

### Response

<%= headers 204 %>

## Remove all Projects from a Group

~~~
DELETE /imports/:id/projects/
~~~

### Response

<%= headers 204 %>

## Delete a Group

~~~
DELETE /groups/:id/
~~~

### Response

<%= headers 204 %>