---
layout: default
title: Import
---

## List Imports

~~~
GET /imports/
~~~

### Parameters

type
: *Optional* **string**: the type of the import. Accepted values are:

	* `freckle`
	* `basecamp`
	* `freshbooks`
	* `harvest`
	* `tempo`
	* `toggl`

user
: *Optional* **integer**: the ID of the user who started the import.

fallback_user
: *Optional* **integer**: the ID of the user who was designated as the fallback user for entries where the user did not exist. if `null` is explictly passed, then only `null` entries are returned.

import_tags
: *Optional* **boolean**: `true` returns imports where tags were imported. `false` returns imports were tags were not imported.

autocreate_projects
: *Optional* **boolean**: `true` returns imports where projects were autocreated. `false` returns imports were projects were not autocreated.


## Get a Single Import

~~~
GET /imports/:id
~~~

<%= headers 200 %>
<%= json :import %>

## Creating an Import

~~~
POST /imports/
~~~

### An Important Note about Uploading Files
In order to create an import, you must send the request parameters as traditional HTTP key/value pairs and set the `Content-Type` header to `application/x-ww-form-urlencoded`. For more details, please review the API Basics section on [Uploading Files](/#uploading-files)

### Input

file
: *Required* **file**: an HTTP file object containing the import file

type
: *Optional* **string**: the file format for this import. Accepted values are:

	* `auto` (**Default**)
	* `freckle`
	* `basecamp`
	* `freshbooks`
	* `harvest`
	* `tempo`
	* `toggl`

fallback_user
: *Optional* **integer**: the user who will be used if the user for an entry cannot be found. If `null` is passed, then entries where the user cannot be found will be ignored. Defaults to the authenticated user.

### Response

<%= headers 202 %>
<%= json :created_import_response %>

## Checking an Import's status

You can check on the status of the import by using the following URL:

~~~
GET /imports/:id/status
~~~

### Response

<%= headers 200 %>
<%= json :import_status %>

Possible values are:

* in_progress
* complete

## Get the details of an import

You can get the details of a report once it has been completed by using the following URL:

~~~
GET /imports/:id/details
~~~

### Response

<%= headers 200 %>
<%= json :import_details %>

### Getting the details of an import that is still in progress

<%= headers 204 %>

## Get the entries created by an import

~~~
GET /imports/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "imports/:id/entries" %>
<%= json :entry %>

## Get the tags created by an import

~~~
GET /imports/:id/tags
~~~

### Parameters

You can use the parameters specified in the [Tag API's List Action](/tags/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "imports/:id/tags" %>
<%= json :tag %>

## Get the projects created by an import

~~~
GET /imports/:id/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "imports/:id/projects" %>
<%= json :project %>

## Deleting an Import

Deleting an import means that the imported entries, tags and projects will be deleted. Entries updated after they were imported will be deleted as well. However, Imported projects and tags containing non-import entries will be preserved.

~~~
DELETE /imports/:id
~~~

### Response

<%= headers 204 %>