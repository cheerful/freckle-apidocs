---
layout: default
title: Tag
---

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

## Create multiple Tags at once

~~~
POST /tags/
~~~

### Inputs

names
: *Required* **array of string**
: The names of the tags to create. Adding a "*" at the end of a string indicates that the tag is unbillable.

### Response

<%= headers 201 %>
<%= json_array :tag %>

### A note about tag creation

Any tag that cannot be created or already exists will be ignored and not affect the response

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
PUT /tags/:id
~~~

### Inputs

name
: *Optional* **string**
: The name for the tag. Adding a "*" at the end of the string indicates that the tag is unbillable.

### Response

<%= headers 200 %>
<%= json :tag %>

### Custom Error Codes

* **locked**: The tag is currently locked for merging and cannot be modified.

## Merge a Tag into this Tag

When one tag is merged into another, the entries associated with the tag are associated with the new tag, and any instances of the old tags are replaced with the new tags in the Entry Description. **This action is permanent**, so you cannot undo after you merge tags.

~~~
PUT /tags/:id/merge
~~~

### Inputs

tag_id
: *Required* **integer**
: The ID of the tag to merge into this tag.

### Response

<%= headers 204 %>

### Custom Error Codes

* **locked**: The tag is currently locked for merging and cannot be modified.

## Delete a Tag

When a tag is deleted, the entries associated with that tag **are not** deleted. Instead, their descriptions are updated so that the tag's text becomes part of the description.

~~~
DELETE /tags/:id
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

* **locked**: The tag is currently locked for merging and cannot be modified.

## Delete Multiple Tags at once

When a tag is deleted, the entries associated with that tag **are not** deleted. Instead, their descriptions are updated so that the tag's text becomes part of the description.

~~~
PUT /tags/delete
~~~

### Inputs

tag_ids
: *Required* **array of integers**
: The IDs of the tags to delete. If no IDs are provided, then no tags are deleted.

### Response

<%= headers 204 %>


### A note about Tags that cannot be deleted

Any entries that are included in this request that cannot be deleted will be ignored and will not affect the Response.
