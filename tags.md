---
layout: default
title: Tags
---

Currently the only available tags API method is listing tags.

List tags
--------------

    GET /api/tags

The tags resource returns all tags for the account.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/tags.json
{% endhighlight %}

Response:

{% highlight js %}
[
  {
    "tag": {
      "name": "a",
      "billable": true,
      "created_at": "2010-06-09T20:44:57Z",
      "import_id": null,
      "updated_at": "2010-06-09T20:44:57Z",
      "account_id": 5039,
      "id": 55629
    }
  }
  /* ...more tags... */
]
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/684cc1abac7137e24757f6f75cbbd16e3d20e6f4/43ef044616088dee5cbb94e4e254271c40120908"><img src="hurl.png" width="35"></a>.
</div>
<div class="tab xml">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/tags.xml
{% endhighlight %}

Response:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<tags type="array">
  <tag>
    <account-id type="integer">5039</account-id>
    <billable type="boolean">true</billable>
    <created-at type="date time">2010-06-09T20:44:57Z</created-at>
    <id type="integer">55629</id>
    <import-id type="integer" nil="true"></import-id>
    <name>a</name>
    <updated-at type="date time">2010-06-09T20:44:57Z</updated-at>
  </tag>
  <!-- ...more tags... -->
</tags>
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/32172677f730772b2bf29ed8c816fc00dd7277ef/05ceba40a58d8800d6b2a0be136dbaee6a1f4a8d"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and an array of tags in the response body.

### Roles

Freelancers have access to this resource, but will only see tags that are used in assigned projects.
