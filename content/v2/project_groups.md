---
layout: default
title: Project Group
---

* TOC
{:toc}

## List project groups

~~~
GET /project_groups/
~~~

### Parameters

name
: *Optional* **string**
: Only project groups containing this string in their name will be returned.
: Example: `name=Sprockets`

project_ids
: *Optional* **string**
: A comma-separated list of project IDs to filter by.
: Example: `project_ids=1,2,3`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups" %>
<%= json_array :project_group %>


## Create a project group

~~~
POST /project_groups/
~~~

### Inputs

name
: *Required* **string**
: The name of the project group.

project_ids
: *Required* **array of integers**
: The IDs of the projects to include in this project group.
: projects that are assigned to an existing project group will be reassigned to this project group.

<%= json :project_group_create_fields %>

### Response

<%= headers 201, :Location => "#{API_V2_URL}/project_groups/1"  %>
<%= json :project_group %>

## Get a project group

~~~
GET /project_groups/:id
~~~

### Response

<%= headers 200 %>
<%= json :project_group %>

## Edit a project group

~~~
PUT /project_groups/:id/
~~~

### Inputs

name
: *Optional* **string**
: The name of the project group

<%= json :project_group_edit_fields %>

### Response

<%= headers 200 %>
<%= json :project_group %>

## Get the entries for projects in a project group

~~~
GET /project_groups/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/v2/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/entries" %>
<%= json_array :entry %>

## Get the projects in a project group

~~~
GET /project_groups/:id/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/v2/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "project_groups/:id/projects" %>
<%= json_array :project %>

## Add projects to a project group

~~~
POST /project_groups/:id/add_projects
~~~

### Input

project_ids
: *Required* **array of integers**
: The IDs of the projects to add to the project group. Any projects that are already associated with another project group will be ignored and will not affect the Response.

### Response

<%= headers 200 %>
<%= json_array :project %>

## Remove projects from project group

~~~
PUT /project_groups/:id/remove_projects
~~~

### Input

project_ids
: *Required* **array of integers**
: The IDs of the projects to remove from the project group. Any projects that are not associated with the project group will be ignored and will not affect the Response.

### Response

<%= headers 204 %>

## Remove all projects from a project group

~~~
PUT /project_groups/:id/remove_all_projects
~~~

### Response

<%= headers 204 %>

## Delete a project group

When a project group is deleted, the project in the project group **are not** deleted. Instead, they are not associated with any project group.

~~~
DELETE /project_groups/:id/
~~~

### Response

<%= headers 204 %>