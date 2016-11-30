---
layout: default
title: Team
---

* TOC
{:toc}

## List teams

~~~
GET /teams/
~~~

### Parameters

name
: *Optional* **string**
: Only teams containing this string in their name will be returned.
: Example: `name=Sprockets`

user_ids
: *Optional* **string**
: A comma-separated list of user IDs to filter by.
: Example: `user_ids=1,2,3`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "teams" %>
<%= json_array :team %>


## Create a team

~~~
POST /teams/
~~~

### Inputs

name
: *Required* **string**
: The name of the team.

user_ids
: *Required* **array of integers**
: The IDs of the users to include in this team.
: Users can be assigned to multiple teams at once.

<%= json :team_create_fields %>

### Response

<%= headers 201, :Location => "#{API_V2_URL}/teams/1"  %>
<%= json :team %>

## Get a team

~~~
GET /teams/:id
~~~

### Response

<%= headers 200 %>
<%= json :team %>

## Edit a team

~~~
PUT /teams/:id/
~~~

### Inputs

name
: *Optional* **string**
: The name of the team

<%= json :team_edit_fields %>

### Response

<%= headers 200 %>
<%= json :team %>

## Get the entries for users in a team

~~~
GET /teams/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/v2/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "teams/:id/entries" %>
<%= json_array :entry %>

## Get the users in a team

~~~
GET /teams/:id/users
~~~

### Parameters

You can use the parameters specified in the [User API's List Action](/v2/users/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "teams/:id/users" %>
<%= json_array :user %>

## Add users to a team

~~~
POST /teams/:id/add_users
~~~

### Input

user_ids
: *Required* **array of integers**
: The IDs of the users to add to the team. Users can be assigned to multiple teams at once. Any users that are already associated with the team will be ignored and will not affect the Response.

### Response

<%= headers 200 %>
<%= json_array :user %>

## Remove users from team

~~~
PUT /teams/:id/remove_users
~~~

### Input

user_ids
: *Required* **array of integers**
: The IDs of the users to remove from the team. Any users that are not associated with the team will be ignored and will not affect the Response.

### Response

<%= headers 204 %>

## Remove all users from a team

~~~
PUT /teams/:id/remove_all_users
~~~

### Response

<%= headers 204 %>

## Delete a team

When a team is deleted, the users in the team **are not** deleted.

~~~
DELETE /teams/:id/
~~~

### Response

<%= headers 204 %>