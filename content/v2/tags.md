---
layout: default
title: Tag
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List all Tags

~~~
GET /tags/
~~~

### Parameters

name
: *Optional* **string**
: Only tags containing this string will be returned.
: Example: `name=meeting`

billable
: *Optional* **boolean**
: `true`: return all billable tags.
: `false`: returns all unbillable tags.

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
: *Optional* **string**
: The name for the tag. Adding a "*" at the end of the string indicates that the tag is unbillable.

### Response

<%= headers 200 %>
<%= json :tag %>

## Merge Tags into this tag

When one tag is merged into another, the entries associated with the tag are associated with the new tag, and any instances of the old tags are replaced with the new tags in the Entry Description. **This action is permanent**, so you cannot undo after you merge tags.

~~~
PUT /tags/:id/merge
~~~

### Inputs

tags
: *Required* **array of integers**
: The IDs of the tags to merge into this tag.

### Response

<%= headers 204 %>

## Delete a Tag

When a tag is deleted, the entries associated with that tag **are not** deleted. Instead, their descriptions are updated so that the tag's text becomes part of the description.

~~~
DELETE /tags/:id
~~~

### Response

<%= headers 204 %>

## Delete Multiple Tags at once

When a tag is deleted, the entries associated with that tag **are not** deleted. Instead, their descriptions are updated so that the tag's text becomes part of the description.

~~~
DELETE /tags/
~~~

### Inputs

tags
: *Required* **array of integers**
: The IDs of the tags to delete. If no IDs are provided, then no tags are deleted.

### Response

<%= headers 204 %>
