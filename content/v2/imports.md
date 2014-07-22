---
layout: default
title: Import
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List Imports

~~~
GET /imports/
~~~

### Parameters

format
: *Optional* **string**
: The format of the import. Accepted values are:

  * `freckle`
  * `basecamp`
  * `freshbooks`
  * `harvest`
  * `tempo`
  * `toggl`

user
: *Optional* **integer**
: The ID of the user who started the import.
: Example: `user=1`

fallback_user
: *Optional* **integer**
: The ID of the user who was designated as the fallback user for entries where the user did not exist. If `null` is explictly passed, then only imports without a fallback user will be returned.
: Example: `user=null`

import_tags
: *Optional* **boolean**
: `true` returns imports where tags were imported. `false` returns imports were tags were not imported.
: Example: `import_tags=true`

autocreate_projects
: *Optional* **boolean**
: `true` returns imports where projects were autocreated. `false` returns imports were projects were not autocreated.
: Example: `autocreate_projects=true`

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only imports from or after this date will be returned.
: Example: `from=2013-09-27`

to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only imports on or before this date will be returned.
: Example: `to=2013-09-27`

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

### An important note about when an import is processed:

When an import is created, it is not immediately processed. Instead, it is sent to a background queue to be processed. After an import is created, you can [check whether it has been processed or is still in progress](#checking-an-imports-status)

### Input

file
: *Required* **file**
: An HTTP file object containing the import file

type
: *Optional* **string**
: The file format for this import. Accepted values are:

  * `autodetect` (**Default**)
  * `freckle`
  * `basecamp`
  * `freshbooks`
  * `harvest`
  * `tempo`
  * `toggl`

create_projects
: *Optional* **boolean**
: `true` (**Default**): The import creates any projects it finds that are not in Freckle
: `false`: Entries in the import that are associated with projects that are not in Freckle will be imported, but will not be assigned to any project.

fallback_user
: *Optional* **integer**
: The ID of the user who will be assigned to entries where the user cannot be found. If `null` is passed, then entries where the user cannot be found will be ignored. If no value is provided, then the authenticated user will be used.

field_delimeter
: *Optional* **string**
: The custom field delimeter used in your CSV. If no value is provided, Freckle will attempt to auto-detect the field delimeter used.

### Response

<%= headers 202 %>
<%= json :created_import_response %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invalid_file**: The uploaded file is not a valid CSV file
* **too_large**: The uploaded file is too large
* **invalid_filed_delimeter**: the field delimeter provided was invalid

## Checking an Import's status

When an import is created, it is not immediately processed. Instead, it is sent to a background queue to be processed. This action will allow you to check the status of the import.

The Possible values are:

* `in_progress`
* `complete`

~~~
GET /imports/:id/status
~~~

### Response

<%= headers 200 %>
<%= json :import_status %>

## Get the details of an import

You can use this action to get the details of a completed import. The following information is returned:

* The number of entries that are imported or discarded
* The users in the import that were not found in Freckle
* Any projects in the import that were found in Freckle
* Any errors for individual lines in the import. Each line error includes:
  * The line where the error occured
  * The fields that were parsed for this line
  * The error message

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

Deleting an import means that the imported entries, tags, and projects will be deleted. Entries updated after they were imported will be deleted as well. **However, Imported projects and tags containing non-import entries will be preserved.**

~~~
DELETE /imports/:id
~~~

### Response

<%= headers 204 %>