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

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 404 Not Found

  An error occurred. Project with given id not exists.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone has access to this resource.

<a id="activate"></a>Activate project
-------------

   GET /api/projects/<id>/active

Sample request:

    curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/active.xml

In case the project was successfully activated, you get a `HTTP 200 Ok` back, with the `Location` header containing the URL of the project (e.g. https://apitest.letsfreckle.com/api/project/2).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 404 Not Found

  An error occurred. Project with given id not exists.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone except freelancers can activate projects.

<a id="archive"></a>Archive project
-------------

    GET /api/projects/<id>/archive

Sample request:

    curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2/archive.xml

In case the project was successfully archived, you get a `HTTP 200 Ok` back, with the `Location` header containing the URL of the project (e.g. https://apitest.letsfreckle.com/api/project/2).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 404 Not Found

  An error occurred. Project with given id not exists.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone except freelancers can archive projects.

<a id="create"></a>Add project
-----------

    POST /api/projects

Sample request:

    curl -d @data/project.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
      https://apitest.letsfreckle.com/api/projects.xml

Sample POST body:

    <?xml version="1.0" encoding="UTF-8"?>
    <project>
      <name>foobar</name>
    </project>

In case the project was successfully created, you get a `HTTP 201 Created` back, with the `Location` header containing the URL of the project (e.g. https://apitest.letsfreckle.com/api/project/123).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  An error occurred. The project already exists or the account project limit has been reached

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone except freelancers can create projects.

<a id="delete"></a>Remove project
-----------

    DELETE /api/projects/<id>

Removed can be only projects without any entries, expenses and invoices.

Sample request:

    curl -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects/2.xml


In case the project was successfully removed, you get a `HTTP 200 Ok` back, with the `Location` header containing the URL of the project (e.g. https://apitest.letsfreckle.com/api/project/123).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 404 Not Found

  An error occurred. Project with given id not exists.

* 422 Unprocessable Entity

  An error occurred. The project have some entries, expenses or invoices.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone except freelancers can remove projects.
