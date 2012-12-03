---
layout: default
title: Projects
---

Jump to: [List](#list) | [Create](#create) | [Read](#read), [Update](#update) | [Delete](#delete) | [Archive](#archive) | [Activate](#activate)

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
      "minutes":0,
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
    <minutes type="integer">0</minutes>
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

<a id="delete"></a>Remove project
-----------

    DELETE /api/projects/<id>

Removed can be only projects without any entries, expenses and invoices.

Sample request:

    curl -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2.xml



### Roles

Everyone except freelancers can remove projects.
