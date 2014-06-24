---
layout: v1
title: Projects
description: Access Freckle projects with the Freckle Time Tracking RESTful API.
---

* TOC
{:toc}

## List projects

    GET /api/projects

The projects resource returns projects accessible by the user. For all roles except freelancers this includes all projects in the account. Freelancers see all projects they currently have been given access to. This method returns active and archived projects.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
Example request (<a href="http://apitest.developer.letsfreckle.com/hurls/fad3d73a5f2d60de3a41397d330e75856beeaddd/147e67ebb705a6a4a60bbf5f6b38883bc9f906b7">try live</a>):


<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.json
<%= code_block_end_tag %>

Response:

<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.xml
<%= code_block_end_tag %>

Response:


<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;projects</span> <span class="na">type=</span><span class="s">&quot;array&quot;</span><span class="nt">&gt;</span>
  <span class="nt">&lt;project&gt;</span>
    <span class="nt">&lt;account-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5039<span class="nt">&lt;/account-id&gt;</span>
    <span class="nt">&lt;billable</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/billable&gt;</span>
    <span class="nt">&lt;billable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/billable-minutes&gt;</span>
    <span class="nt">&lt;budget</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/budget&gt;</span>
    <span class="nt">&lt;cached-tags</span> <span class="na">type=</span><span class="s">&quot;yaml&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/cached-tags&gt;</span>
    <span class="nt">&lt;color-hex&gt;</span>f1f353<span class="nt">&lt;/color-hex&gt;</span>
    <span class="nt">&lt;created-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2010-11-30T21:56:39Z<span class="nt">&lt;/created-at&gt;</span>
    <span class="nt">&lt;enabled</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/enabled&gt;</span>
    <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>34572<span class="nt">&lt;/id&gt;</span>
    <span class="nt">&lt;import-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/import-id&gt;</span>
    <span class="nt">&lt;invoice-recipient-details</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/invoice-recipient-details&gt;</span>
    <span class="nt">&lt;minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/minutes&gt;</span>
    <span class="nt">&lt;name&gt;</span>Activity_1_doloressequiunde<span class="nt">&lt;/name&gt;</span>
    <span class="nt">&lt;project-group-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/project-group-id&gt;</span>
    <span class="nt">&lt;stepping</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>15<span class="nt">&lt;/stepping&gt;</span>
    <span class="nt">&lt;unbillable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/unbillable-minutes&gt;</span>
    <span class="nt">&lt;updated-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2011-10-19T15:59:56Z<span class="nt">&lt;/updated-at&gt;</span>
    <span class="nt">&lt;user-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/user-id&gt;</span>
    <span class="nt">&lt;budget-minutes</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/budget-minutes&gt;</span>
    <span class="nt">&lt;remaining-minutes</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/remaining-minutes&gt;</span>
    <span class="nt">&lt;unbillable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/unbillable-minutes&gt;</span>
    <span class="nt">&lt;group-name</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/group-name&gt;</span>
  <span class="nt">&lt;/project&gt;</span>
  <span class="c">&lt;!-- ...more projects... --&gt;</span>
<span class="nt">&lt;/projects&gt;</span>
</code></pre>
</div>


</div>
</div>

### Response codes

If successful, the response code is **`200 OK`** with the results of the call given in the response body.

### Roles

All roles have access to this resource. For freelancers, only projects they have access to are returned.

### Structure of a project

Here's an example project and a description of all the fields returned.

<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>

## Show project

    GET /api/projects/<id>

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.json
<%= code_block_end_tag %>

Response:

<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>

</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.xml
<%= code_block_end_tag %>

Response:


<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;project&gt;</span>
  <span class="nt">&lt;account-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5039<span class="nt">&lt;/account-id&gt;</span>
  <span class="nt">&lt;billable</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/billable&gt;</span>
  <span class="nt">&lt;billable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/billable-minutes&gt;</span>
  <span class="nt">&lt;budget</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/budget&gt;</span>
  <span class="nt">&lt;cached-tags</span> <span class="na">type=</span><span class="s">&quot;yaml&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/cached-tags&gt;</span>
  <span class="nt">&lt;color-hex&gt;</span>f1f353<span class="nt">&lt;/color-hex&gt;</span>
  <span class="nt">&lt;created-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2010-11-30T21:56:39Z<span class="nt">&lt;/created-at&gt;</span>
  <span class="nt">&lt;enabled</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/enabled&gt;</span>
  <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>34572<span class="nt">&lt;/id&gt;</span>
  <span class="nt">&lt;import-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/import-id&gt;</span>
  <span class="nt">&lt;invoice-recipient-details</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/invoice-recipient-details&gt;</span>
  <span class="nt">&lt;minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/minutes&gt;</span>
  <span class="nt">&lt;name&gt;</span>Activity_1_doloressequiunde<span class="nt">&lt;/name&gt;</span>
  <span class="nt">&lt;project-group-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/project-group-id&gt;</span>
  <span class="nt">&lt;stepping</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>15<span class="nt">&lt;/stepping&gt;</span>
  <span class="nt">&lt;unbillable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/unbillable-minutes&gt;</span>
  <span class="nt">&lt;updated-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2011-10-19T15:59:56Z<span class="nt">&lt;/updated-at&gt;</span>
  <span class="nt">&lt;user-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/user-id&gt;</span>
  <span class="nt">&lt;minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/minutes&gt;</span>
  <span class="nt">&lt;budget-minutes</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/budget-minutes&gt;</span>
  <span class="nt">&lt;remaining-minutes</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/remaining-minutes&gt;</span>
  <span class="nt">&lt;unbillable-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>0<span class="nt">&lt;/unbillable-minutes&gt;</span>
  <span class="nt">&lt;group-name</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/group-name&gt;</span>
<span class="nt">&lt;/project&gt;</span>
</code></pre>
</div>


</div>
</div>

### Response codes

If successful **`200 OK`** with the project information in the response body is returned.

If the project is not known or the user doesn't have access to the project, **`404 Not found`** is returned.

### Roles

All roles have access to this resource.

## Create project

    POST /api/projects

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -d @data/project.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.xml
<%= code_block_end_tag %>

Post body:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;project&gt;</span>
  <span class="nt">&lt;name&gt;</span>foobar<span class="nt">&lt;/name&gt;</span>
<span class="nt">&lt;/project&gt;</span>
</code></pre>
</div>


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

## Update project

    PUT /api/projects/:id

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -X PUT -d @data/project.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/34572.xml
<%= code_block_end_tag %>

Post body:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;project&gt;</span>
  <span class="nt">&lt;name&gt;</span>foobar<span class="nt">&lt;/name&gt;</span>
  <span class="nt">&lt;group_name&gt;</span>Sprockets, Inc.<span class="nt">&lt;/group_name&gt;</span>
  <span class="nt">&lt;billable</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/billable&gt;</span>
  <span class="nt">&lt;budget-minutes</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>60<span class="nt">&lt;/budget-minutes&gt;</span>
  <span class="nt">&lt;color-hex&gt;</span>f1f353<span class="nt">&lt;/color-hex&gt;</span>
<span class="nt">&lt;/project&gt;</span>
</code></pre>
</div>


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

## Delete project

    DELETE /api/projects/<id>

Only projects that do not have any entries, expenses or invoices can be deleted.
We recommend to archive projects instead.

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -v -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2.xml
<%= code_block_end_tag %>
</div>
</div>

### Response codes

If deletion is successful, **`200 OK`** will be returned.

**`422 Unprocessable Entity`** means that one of the preconditions (no entries,
expenses or invoices) was not met. A reason like `Project has entries` will be returned
as plain text in the response body.

### Roles

All roles except freelancers can delete projects.

## Activate project

   GET /api/projects/<id>/active
   
(Re-)Activates an archived project.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/active.json
<%= code_block_end_tag %>
</div>
</div>

### Response codes

If successful or in case the project was already active, **`200 OK`** with a `Location` is returned, pointing to the project.

### Roles

Everyone except freelancers can activate projects.

## Archive project

    GET /api/projects/<id>/archive

Archive a project. Archived projects are "frozen" and time can't be logged for them.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/archive.json
<%= code_block_end_tag %>
</div>
</div>

### Response codes

If successful or in case the project was already archived, **`200 OK`** with a `Location` is returned, pointing to the project.

### Roles

Everyone except freelancers can archive projects.