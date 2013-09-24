---
layout: default
title: Tag
---

## Tag Object Specification
<%= json :tag %>

## List all Tags

~~~
GET /tags/
~~~

### Parameters

name
: *Optional* **string**: Only tags containing this string will be returned.

billable
: *Optional* **boolean**: `true` returns all billable tags, `false` returns all unbillable tags.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "tags" %>
<%= json :tag %>

## Get a single tag

~~~
GET /tags/:id
~~~

### Response

<%= headers 200 %>
<%= json :tag %>

## Get the entries for a tag

~~~
GET /tags/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "tags/:id/entries" %>
<%= json :entry %>

## Edit a Tag

~~~
PATCH /tags/:id
~~~

### Inputs

name
: *Optional* **string**: the new name for the tag. add "*" at the end to make the tag unbillable.

### Response

<%= headers 200 %>
<%= json :tag %>

## Delete a Tag

When a tag is deleted, the entries associated with that tag **are not** deleted. Instead, their descriptions are updated so that the tag's text becomes part of the description.

~~~
DELETE /tags/:id
~~~

### Response

<%= headers 204 %>