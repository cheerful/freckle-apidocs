---
layout: default
title: Entries
---

The entries resource represents logged time. Each entry, at the minimum, is assigned to a user, has 0 or more minutes logged and has a date set (all other fields, including project, tags and description are optional).

Jump to: [List](#list) | [Create](#create) | [Update](#update) | [Delete](#delete) | [Import](#import)

<a id="list"></a>List & Search
-------------

    GET /api/entries

The parameters to list and search entries via the API is very similar to the
blue quick reports box in the Freckle user interface.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
Example request (search for entries with tag "freckle" after December 1, 2010, return JSON), try with 
<a href="http://hurl.it/hurls/31bbedd3f866bd6d68e4c8181c1116d3085d91ad/8922a193b7dd6a4f53ac962428ca1352884a6cf0"><img src="hurl.png" width="35"></a>:

{% highlight sh %}
curl -v -G -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.json -d 'search[tags]=freckle' -d 'search[from]=2010-12-01'
{% endhighlight %}
</div>
<div class="tab xml">
Example request (search for entries tagged "conf call" for user 5538, return XML), try with <a href="http://hurl.it/hurls/36457ed377666e29733df92e0b88ddb9a8fdeb5c/8394c77547a5fb5bc4b83f6de488fe6f1f99017d"><img src="hurl.png" width="35"></a>:

{% highlight sh %}
curl -v -G -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.xml -d 'search[people]=5538' -d 'search[tags]=conf call'
{% endhighlight %}
</div>
</div>

Supported options for searching are:

* `people`: comma separated user ids
* `projects`:  comma separated project ids
* `tags`: comma separated tag ids or names (can be mixed, multiple tags will search using AND)
* `from`: entries from this date
* `to`: entries to this date
* `billable`: _true_ only shows billable entries; _false_ only shows unbillable entries

Entries are returned sorted descending by date.

<p class="note">
Please note that API call can return a very large number of entries and might take a while
to execute. Currently we're not limiting the number of returned entries, but we reserve
the right to do so in the future (and add paging).
</p>

### Roles

All roles can list entries. Freelancers will only see entries made by themselves
in projects they currently have access to.

### Structure of an entry

Here's an example entry and a description of all the fields returned.

{% highlight js %}
{
  "entry": {
    // ID of the entry (integer)
    "id": 1711626,
    
    // date the time is logged for YYYY-MM-DD
    "date": "2012-01-09",
    // User ID the time is logged for (integer)
    "user_id": 5538,

    // false if entry or project are unbillable
    "billable": true,
    // UTC timestamp when entry was created
    "created_at": "2012-01-09T08:33:29Z",
    // logged time in minutes (integer)
    "minutes": 60,
    // UTC timestamp when entry was last updated
    "updated_at": "2012-01-09T08:33:29Z",
    // full description text (includes tags)
    "description": "freckle",

    // All following fields are OPTIONAL
    // (optional) project_id, can be null
    "project_id": 37396,                         
    // (optional) array of tags assigned to entry
    "tags": [                                      
      {
        "name": "freckle",
        "billable": true,
        "id": 249397
      }
    ],
    // (optional) link to source of entry (e.g. Github commit)
    "url": null,
    // (optional) UTC timestamp when entry was added to an invoice
    "invoiced_at": null,
    // (optional) Invoice ID
    "project_invoice_id": null,
    // (optional) set if imported from a file
    "import_id": null,
    
    // all following fields are deprecated, and will 
    // be removed in the next API version
    "time_to": null,                               
    "recently_updated_at": "2012-01-09T08:33:29Z", 
    "description_text": "",                        
    "formatted_description": "",                   
    "money_status": "not_invoiced",                
    "time_from": null,                             
    "billable_status": "billable"                  
  }
}
{% endhighlight %}

<p class="note">
Please note that in Freckle an entry does not have to belong to a Project so the 
project_id field is optional. It's set to <code>null</code> in JSON or 
<code>&lt;project-id type='integer' nil='true'/&gt;</code> in XML
when there's no project assigned to an entry. Make sure your application does not
expect project IDs to be present.
</p>

<a id="create"></a>Creating entries
---------------------

    POST /api/entries

This call creates a single entry. The data for the entry must be given in the 
post body, as either XML or JSON.

Sample request:

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">

This call assumes there's an <code>entry.json</code> file in the current directory:

{% highlight sh %}
$ curl -v -d @entry.json -H "Content-type: application/json" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.json
{% endhighlight %}

Here's what <code>entry.json</code> looks like:

{% highlight json %}
{
  "entry": {
    "minutes": "2h",
    "user": "apitest@letsfreckle.com",
    "project-id": 8475,
    "description": "Freckle RESTful API test",
    "date": "2012-12-02"
  }
}
{% endhighlight %}

Try this example on <a href="http://hurl.it/hurls/2247782b74ea116e23ca09ddab147f597590f46b/04836270410bdf2eccca12361dcd03a4569b0db2"><img src="hurl.png" width="35"></a>.

</div>
<div class="tab xml">

This call assumes there's an <code>entry.xml</code> file in the current directory:

{% highlight sh %}
$ curl -v -d @entry.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.xml
{% endhighlight %}

Here's what <code>entry.xml</code> looks like:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<entry>
  <minutes>2h</minutes>
  <user>apitest@letsfreckle.com</user>
  <project-id type="integer">8475</project-id>
  <description>freckle restful api test</description>
  <date>2009-10-15</date>
</entry>
{% endhighlight %}

Try this example on <a href="http://hurl.it/hurls/e3ad022b4f7b750f98dc70245c3cf9f250efbf72/0eb353652d77578e976492782882e9639721b450"><img src="hurl.png" width="35"></a>.

</div>
</div>

### Entry attributes

These are the **required attributes** when creating new entries:

**`minutes`** (required) is a string containing the amount of time which should be 
logged for the entry. Freckle uses the <a href="http://letsfreckle.com/blog/2011/10/more-than-meets-the-eye-the-quick-entry-box/">same logic that the QuickEntry box uses</a>
to parse the minutes field:

    0:01 → 1 minute
    0:30 → 30 minutes
    0.5  → 30 minutes
    1    → 1 hour
    5    → 5 hours
    5m   → 5 minutes
    15   → 15 minutes
    15h  → 15 hours
  
If you do your own time parsing, we recommended to use the `HH:MM` format
in this field.

**`date`** (required) is the date the entry should be logged for, given as YYYY-MM-DD.
 
The following fields are **optional**:
   
**`user`** (optional) can contain a user ID, the email address of a user
or the full name of a user (first name and last name separated by a single space).
If no user is given time is logged for the user authorized by the API token.

**`project_id`** (optional) specifies the ID of the project the entry should be 
associated with. This field takes precedence if `project_name` is given also.

**`project_name`** (optional) specifies the name of the project the entry should be 
associated with.

**`description`** (optional) contains the entries description, including tags. Tags are any
substrings of the description that are not preceded by a "!!",
are one or two words in length, start and end with the beginning of the 
entry, the end of the entry or a comma ",", are 30 characters or less in
total and don't start with a "!". 

Here are some examples how tags are parsed:

{% highlight js %}
// no tags; description text: "This is a description."
"This is a description."

// tags: TagA, Tag B; no description text
"TagA, Tag B"

// tags: TagA, Tag B; description text: ThisWouldBeATagButItsLongerThan30Chars
"TagA, Tag B, ThisWouldBeATagButItsLongerThan30Chars"

// no tags; description text: "TagA, TagB"
"!!TagA, Tag B"

// tags: TagB; description text: "TagA"
"!TagA, Tag B"

// tags: TagA; description text: "TagB"
"TagA, !Tag B"

// tags: TagA; description text: "This is quite the description"
"This is quite the description, TagA"
{% endhighlight %}

A "!!" anywhere in the description will stop tag parsing afterwards.

Descriptions are automatically normalized by Freckle, by removing any extra whitespace,
and moving tags to the front in alphabetical order.

### Response codes

**`201 Created`** means that the entry was successfully created in is now visible in Freckle. The `Location` header in the HTTP response contains the path to this
new entry in the API. This path contains the entry ID which your application can
store so it can update the same entry later.
  
Here's an example response:

    HTTP/1.1 201 Created
    Server: nginx/1.2.1
    Date: Sun, 02 Dec 2012 20:56:54 GMT
    Content-Type: application/json; charset=utf-8
    Content-Length: 1
    Connection: keep-alive
    Status: 201 Created
    Location: /api/entries/3187878
    X-Runtime: 33
    Cache-Control: private, max-age=0, must-revalidate

**`422 Unprocessable Entity`** means the request data was not valid, for example a
required field was omitted, or the exact same entry was submitted within the last
minute (this prevents duplicates).

### Roles

All roles can access this resource. Freelancers can only create entries in
for projects which they currently have access to (you can query the list of
projects through the Projects resource.

<a id="update"></a>Update entries
---------------

    PUT /api/entries/<id>
    
Update a single entry, that is not invoiced and doesn't 
belong to an archived project.

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
Sample request (assumes a `entry.xml` file in the current directory`):

{% highlight sh %}
$ curl -v -X PUT -d @entry.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries/33.xml
{% endhighlight %}

Contents of PUT body (`entry.xml` file in current directory):

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<entry>
  <minutes>2h</minutes>
  <user>apitest@letsfreckle.com</user>
  <project-id type="integer">8475</project-id>
  <description>freckle restful api test</description>
  <date>2009-10-15</date>
</entry>
{% endhighlight %}
</div>
</div>

### Entry attributes

See POST /api/entries for a reference.

### Response codes

**`200 OK`** is returned when the entry was updated successfully.

**`422 Unprocessable Entity`** means the request data was not valid, for example a
required field was omitted, the entry is already invoiced or that the entry belongs
to an archived project.

### Roles

All roles can access this resource. Freelancers can only create entries in
for projects which they currently have access to (you can query the list of
projects through the Projects resource.

<a id="delete"></a>Deleting entries
---------------------

    DELETE /api/entries/<id>

Delete a single entry, that is not invoiced and
doesn't belong to an archived project.

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
Sample request:

{% highlight sh %}
curl -v -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries/33.xml
{% endhighlight %}
</div>
</div>

### Response codes

**`200 OK`** is returned when the entry was deleted successfully.

**`422 Unprocessable Entity`** means that the entry is already 
invoiced or that the entry belongs to an archived project.

### Roles

All roles can access this resource. Freelancers can only create entries in accessible projects. You can fetch the accessible projects through the Projects resource.

<a id="import"></a>Bulk import
-----------

    POST /api/entries/import

Use this API method instead of individual calls to POST /api/entries to create a larger number of entries at once. This is great when you want to import existing data to your Freckle account, and also a great fit for applications that collect data offline and want to bulk upload entries in one go.

<p class="note">This is not the same as the *data import* functionality in the Freckle UI (where you can import files from various other services). Imports done with this API call can not be automatically rolled back.</p>

<div class="tabs">
<div class="selector">
  <div class="xml active">XML</div>
</div>
<div class="tab xml active">
Sample request (assumes a `entries_import.xml` file in the current directory):

{% highlight sh %}
$ curl -d @entries_import.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries/import.xml
{% endhighlight %}

Sample POST body:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<entries>
  <entry>
    <minutes>2h</minutes>
    <user>apitest@letsfreckle.com</user>
    <project-name>Fixture Company</project-name>
    <description>freckle restful api test, bulk import</description>
    <date>2009-10-11</date>
  </entry>
  <entry>
    <minutes>30min</minutes>
    <user>apitest@letsfreckle.com</user>
    <description>freckle restful api test, bulk import</description>
    <date>2009-10-12</date>
  </entry>
</entries>
{% endhighlight %}
</div>
</div>

### Entry attributes

Entry attributes are the same as for `POST /api/entries`.

<p class="note">
Please note that for historical reasons, for bulk imports only the `project_name` field takes
precedence over the `project_id` field if both are given.
</p>

### Response codes

**`200 OK`** means that the the bulk import completed successfully. The response body will contain
an array of the newly created entries:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<entries type="array">
  <entry>
    <billable type="boolean">true</billable>
    <created-at type="date time">2009-10-16T09:57:22Z</created-at>
    <date type="date">2009-10-11</date>
    <description>freckle restful api test, bulk import</description>
    <id type="integer">83601</id>
    <minutes type="integer">120</minutes>
    <project-id type="integer">8475</project-id>
    <updated-at type="date time">2009-10-16T09:57:22Z</updated-at>
    <url nil="true"></url>
    <user-id type="integer">5538</user-id>
  </entry>
  <entry>
    <billable type="boolean">true</billable>
    <created-at type="date time">2009-10-16T09:57:22Z</created-at>
    <date type="date">2009-10-12</date>
    <description>freckle restful api test, bulk import</description>
    <id type="integer">83602</id>
    <minutes type="integer">30</minutes>
    <project-id type="integer" nil="true"></project-id>
    <updated-at type="date time">2009-10-16T09:57:22Z</updated-at>
    <url nil="true"></url>
    <user-id type="integer">5538</user-id>
  </entry>
</entries>
{% endhighlight %}

**`422 Unprocessable Entity`** means the no entries where created,
for example when the import data didn't contain any items, or all
entries referenced users that don't exist or a no longer active.

### Roles

Every role except for freelancers can use the import entries API method.