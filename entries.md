---
layout: default
title: Entries
---

The entries resource can be used to list/search, read, create, 
update, delete, and mass import time entries (logged time).

List & Search
-------------

    GET /api/entries.xml

The parameters to list and search entries via the API is very similar to the
blue quick reports box in the Freckle user interface.

Example request (search for entries tagged "conf call" for user 5538, return XML), try with <a href="http://hurl.it/hurls/36457ed377666e29733df92e0b88ddb9a8fdeb5c/8394c77547a5fb5bc4b83f6de488fe6f1f99017d"><img src="hurl.png" width="35"></a>:

{% highlight sh %}
curl -v -G -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.xml \
  -d 'search[people]=5538' -d 'search[tags]=conf call'
{% endhighlight %}

Example request (search for entries with tag "freckle" after December 1, 2010, return JSON), try with 
<a href="http://hurl.it/hurls/31bbedd3f866bd6d68e4c8181c1116d3085d91ad/8922a193b7dd6a4f53ac962428ca1352884a6cf0"><img src="hurl.png" width="35"></a>:

{% highlight sh %}
curl -v -G -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries.json \
  -d 'search[tags]=freckle' -d 'search[from]=2010-12-01'
{% endhighlight %}

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

Here's an example entry and a description of all the field returned.

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

Creating an entry
---------------------

    POST /api/entries.xml

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

Edit a time entry
---------------------

Changed can be only entries which are not invoiced yet and not belongs to archived project.

PUT `/api/entries/33.xml`

Sample request:

    curl -X PUT -d @data/entry.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
      https://apitest.letsfreckle.com/api/entries/33.xml

Sample PUT body:

    <?xml version="1.0" encoding="UTF-8"?>
    <entry>
      <minutes>2h</minutes>
      <user>apitest@letsfreckle.com</user>
      <project-id type="integer">8475</project-id>
      <description>freckle restful api test</description>
      <date>2009-10-15</date>
    </entry>

### Entry attributes

* minutes

  Amount of time which should be tracked for the entry in a valid format

* user

  email or login of the user the entry should be associated with

* project-id

  ID of the project the entry should be associated with

* description

  Description for the entry, including tags

* date

  Date formated in YYYY-MM-DD

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  The request data was not valid.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

All roles can access this resource. Freelancers can only create entries in accessible projects. You can fetch the accessible projects through the Projects resource.

Remove a time entry
---------------------

Removed can be only entries which are not invoiced yet and not belongs to archived project.

DELETE `/api/entries/33.xml`

Sample request:

    curl -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/entries/33.xml

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  The request data was not valid.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

All roles can access this resource. Freelancers can only create entries in accessible projects. You can fetch the accessible projects through the Projects resource.

Bulk import
-----------

You can POST a big bunch of entries to this resource to create a large number of entries at once. This is great when you want to import existing data to your Freckle accunt.

POST `/api/entries/import.xml`

Sample request:

    curl -d @data/entries_import.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
     https://apitest.letsfreckle.com/api/entries/import.xml

Sample POST body:

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

### Entry attributes

*ATTENTION*: the entry format for the import is slightly different to the format used for the create single entry format!

* minutes (*required*)

  Amount of time which should be tracked for the entry in a valid format.

* user (*required*)

  Email or login of the user the entry should be associated with.

* project-name

  Name of the project the entry should be associated with. The project will be created if it doesn't exist.

* description

  Description for the entry, including tags.

* date

  Date formated in _YYYY-MM-DD_


Response:

The response will be an array of all created time entries.

    <?xml version="1.0" encoding="UTF-8"?>
    <entries type="array">
      <entry>
        <billable type="boolean">true</billable>
        <created-at type="datetime">2009-10-16T09:57:22Z</created-at>
        <date type="date">2009-10-11</date>
        <description>freckle restful api test, bulk import</description>
        <id type="integer">83601</id>
        <minutes type="integer">120</minutes>
        <project-id type="integer">8475</project-id>
        <updated-at type="datetime">2009-10-16T09:57:22Z</updated-at>
        <url nil="true"></url>
        <user-id type="integer">5538</user-id>
      </entry>
      <entry>
        <billable type="boolean">true</billable>
        <created-at type="datetime">2009-10-16T09:57:22Z</created-at>
        <date type="date">2009-10-12</date>
        <description>freckle restful api test, bulk import</description>
        <id type="integer">83602</id>
        <minutes type="integer">30</minutes>
        <project-id type="integer" nil="true"></project-id>
        <updated-at type="datetime">2009-10-16T09:57:22Z</updated-at>
        <url nil="true"></url>
        <user-id type="integer">5538</user-id>
      </entry>
    </entries>

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  The request data was not valid.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Everyone can import entries, except for freelancers.