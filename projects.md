---
layout: default
title: Projects
description: Access Freckle projects with the Freckle Time Tracking RESTful API.
---

Jump to: [List](#list) | [Create](#create) | 
[Update](#update) | 
[Read](#read) | 
[Delete](#delete) | [Archive](#archive) | 
[Activate](#activate)

<a id="list"></a>List projects
-------------

    GET /api/projects

The projects resource returns projects accessible by the user. For all roles except freelancers this includes all projects in the account. Freelancers see all projects they currently have been given access to. This method returns active and archived projects.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
Example request (<a href="http://apitest.developer.letsfreckle.com/hurls/fad3d73a5f2d60de3a41397d330e75856beeaddd/147e67ebb705a6a4a60bbf5f6b38883bc9f906b7">try live</a>):


{% highlight sh %}
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.json
{% endhighlight %}

Response:

{% highlight js %}
[
  {
    "project":{
      "name":"Nutsnbolts",
      "unbillable_minutes":0,
      "created_at":"2010-11-30T21:56:39Z",
      "billable":true,
      "budget_minutes":null,
      "minutes":0,
      "cached_tags":null,
      "remaining_minutes":null,
      "updated_at":"2011-10-19T15:59:56Z",
      "import_id":null,
      "account_id":5039,
      "group_name":null,
      "project_group_id":null,
      "id":34580,
      "enabled":true,
      "billable_minutes":0,
      "user_id":null,
      "unbillable_minutes":0,
      "color_hex":"ff9898",
      "budget":null,
      "stepping":15,
      "invoice_recipient_details":null
    }
  }
  // ...more projects...
]
{% endhighlight %}
</div>
<div class="tab xml">
{% highlight sh %}
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.xml
{% endhighlight %}

Response:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<projects type="array">
  <project>
    <account-id type="integer">5039</account-id>
    <billable type="boolean">true</billable>
    <billable-minutes type="integer">0</billable-minutes>
    <budget type="integer" nil="true"></budget>
    <cached-tags type="yaml" nil="true"></cached-tags>
    <color-hex>f1f353</color-hex>
    <created-at type="date time">2010-11-30T21:56:39Z</created-at>
    <enabled type="boolean">true</enabled>
    <id type="integer">34572</id>
    <import-id type="integer" nil="true"></import-id>
    <invoice-recipient-details nil="true"></invoice-recipient-details>
    <minutes type="integer">0</minutes>
    <name>Activity_1_doloressequiunde</name>
    <project-group-id type="integer" nil="true"></project-group-id>
    <stepping type="integer">15</stepping>
    <unbillable-minutes type="integer">0</unbillable-minutes>
    <updated-at type="date time">2011-10-19T15:59:56Z</updated-at>
    <user-id type="integer" nil="true"></user-id>
    <budget-minutes nil="true"></budget-minutes>
    <remaining-minutes nil="true"></remaining-minutes>
    <unbillable-minutes type="integer">0</unbillable-minutes>
    <group-name nil="true"></group-name>
  </project>
  <!-- ...more projects... -->
</projects>
{% endhighlight %}
</div>
</div>

### Response codes

If successful, the response code is **`200 OK`** with the results of the call given in the response body.

### Roles

All roles have access to this resource. For freelancers, only projects they have access to are returned.

### Structure of a project

Here's an example project and a description of all the fields returned.

{% highlight js %}
{
  "project": {
    // ID of the project (integer)
    "id": 34580,    
    // Name of the project
    "name": "Gear GmbH",
    // Group name of the project (or null)
    "group_name": "Sprockets, Inc.",
    // Group ID of the project (or null)
    "project_group_id": 3768,
    
    // UTC timestamp when the project was created
    "created_at": "2012-01-09T08:33:29Z",
    // UTC timestamp when the project was last updated
    "updated_at": "2012-01-09T08:33:29Z",
    
    // total amount of logged minutes (can be null)
    "minutes": 180,
    // total amount of logged billable minutes (can be null)
    "billable_minutes": 120,
    // total amount of unbillable minutes (can be null)
    "unbillable_minutes": 60,
    // total amount of logged invoiced minutes (can be null)
    "invoiced_minutes": 120,
    // amount of remaining minutes within budget (can be null)
    "remaining_minutes": 630,
    // budgeted minutes (can be null)
    "budget_minutes": 750,

    // true if project is billable
    "billable": true,
    // ID of the import if the project was part of an import (can be null)
    "import_id": null,
    // true if project is enabled, false if archived
    "enabled": true,
    // rrggbb hexadecimal color for the project
    "color_hex": "ff9898",
    // billing increment in minutes
    // if you build client software that creates entries
    // it should only allow multiples of stepping logged
    // (in minutes). if the user enters a non-multiple you
    // should round time up.
    "stepping": 10,
    
    // all following fields are deprecated, and may 
    // be removed in the next API version
    "user_id": null,
    "budget": 750,
    "account_id": 5039,
    "invoice_recipient_details": null,
    "cached_tags": [ ... ]
  }
}
{% endhighlight %}

<a id="read"></a>Show project
-------------

    GET /api/projects/<id>

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.json
{% endhighlight %}

Response:

{% highlight js %}
{
   "project":{
      "name":"Activity_1_doloressequiunde",
      "unbillable_minutes":0,
      "created_at":"2010-11-30T21:56:39Z",
      "billable":true,
      "budget_minutes":null,
      "minutes":0,
      "cached_tags":null,
      "remaining_minutes":null,
      "updated_at":"2011-10-19T15:59:56Z",
      "import_id":null,
      "account_id":5039,
      "group_name":null,
      "minutes":0,
      "project_group_id":null,
      "id":34572,
      "enabled":true,
      "billable_minutes":0,
      "user_id":null,
      "unbillable_minutes":0,
      "color_hex":"f1f353",
      "budget":null,
      "stepping":15,
      "invoice_recipient_details":null
   }
}
{% endhighlight %}

</div>
<div class="tab xml">
{% highlight sh %}
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.xml
{% endhighlight %}

Response:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<project>
  <account-id type="integer">5039</account-id>
  <billable type="boolean">true</billable>
  <billable-minutes type="integer">0</billable-minutes>
  <budget type="integer" nil="true"></budget>
  <cached-tags type="yaml" nil="true"></cached-tags>
  <color-hex>f1f353</color-hex>
  <created-at type="date time">2010-11-30T21:56:39Z</created-at>
  <enabled type="boolean">true</enabled>
  <id type="integer">34572</id>
  <import-id type="integer" nil="true"></import-id>
  <invoice-recipient-details nil="true"></invoice-recipient-details>
  <minutes type="integer">0</minutes>
  <name>Activity_1_doloressequiunde</name>
  <project-group-id type="integer" nil="true"></project-group-id>
  <stepping type="integer">15</stepping>
  <unbillable-minutes type="integer">0</unbillable-minutes>
  <updated-at type="date time">2011-10-19T15:59:56Z</updated-at>
  <user-id type="integer" nil="true"></user-id>
  <minutes type="integer">0</minutes>
  <budget-minutes nil="true"></budget-minutes>
  <remaining-minutes nil="true"></remaining-minutes>
  <unbillable-minutes type="integer">0</unbillable-minutes>
  <group-name nil="true"></group-name>
</project>
{% endhighlight %}
</div>
</div>

### Response codes

If successful **`200 OK`** with the project information in the response body is returned.

If the project is not known or the user doesn't have access to the project, **`404 Not found`** is returned.

### Roles

All roles have access to this resource.

<a id="activate"></a>Activate project
-------------

   GET /api/projects/<id>/active
   
(Re-)Activates an archived project.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/active.json
{% endhighlight %}
</div>
</div>

### Response codes

If successful or in case the project was already active, **`200 OK`** with a `Location` is returned, pointing to the project.

### Roles

Everyone except freelancers can activate projects.

<a id="archive"></a>Archive project
-------------

    GET /api/projects/<id>/archive

Archive a project. Archived projects are "frozen" and time can't be logged for them.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/archive.json
{% endhighlight %}
</div>
</div>

### Response codes

If successful or in case the project was already archived, **`200 OK`** with a `Location` is returned, pointing to the project.

### Roles

Everyone except freelancers can archive projects.

<a id="create"></a>Create project
-----------

    POST /api/projects

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
{% highlight sh %}
$ curl -d @data/project.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.xml
{% endhighlight %}

Post body:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<project>
  <name>foobar</name>
</project>
{% endhighlight %}
</div>
</div>

### Response codes

**`201 Created`** means that the project was successfully created in is now visible in Freckle.
The `Location` header in the HTTP response contains the path to this new project in the API. 
This path contains the project ID which your application can
store so it can use the project later in other API calls.

Here's an example response:

    HTTP/1.1 201 Created
    Server: nginx/1.2.1
    Date: Sun, 02 Dec 2012 20:56:54 GMT
    Content-Type: application/json; charset=utf-8
    Content-Length: 1
    Connection: keep-alive
    Status: 201 Created
    Location: /api/projects/3187878
    X-Runtime: 33
    Cache-Control: private, max-age=0, must-revalidate

**`422 Unprocessable Entity`** means the request data was not valid, for example a
required field was omitted, a project with the same name already exists, or the 
1 project limit of free Freckle accounts has been reached.

### Roles

All roles except for the **freelancer** role can create projects.

<a id="update"></a>Update project
-----------

    PUT /api/projects/:id

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
{% highlight sh %}
$ curl -v -X PUT -d @data/project.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.xml
{% endhighlight %}

Post body:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<project>
  <name>foobar</name>
  <group_name>Sprockets, Inc.</group_name>
  <billable type="boolean">true</billable>
  <budget-minutes type="integer">60</budget-minutes>
  <color-hex>f1f353</color-hex>
</project>
{% endhighlight %}
</div>
</div>

### Response codes

**`200 Created`** means that the project was successfully updated

**`422 Unprocessable Entity`** means the request data was not valid, for example a
required field was omitted, a project with the same name already exists, or the 
1 project limit of free Freckle accounts has been reached.

**`400 Bad Request`** means the request data wasn't properly formatted, for example a field has the incorrect data type.

### Roles

All roles except for the **freelancer** role can update projects.

<a id="delete"></a>Delete project
-----------

    DELETE /api/projects/<id>

Only projects that do not have any entries, expenses or invoices can be deleted.
We recommend to archive projects instead.

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
{% highlight sh %}
$ curl -v -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2.xml
{% endhighlight %}
</div>
</div>

### Response codes

If deletion is successful, **`200 OK`** will be returned.

**`422 Unprocessable Entity`** means that one of the preconditions (no entries,
expenses or invoices) was not met. A reason like `Project has entries` will be returned
as plain text in the response body.

### Roles

All roles except freelancers can delete projects.
