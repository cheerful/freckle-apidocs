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

Try with <a href="http://hurl.it/hurls/ddb28de14d7432c64aac2f0a72aaa62531ace8e8/5a1b828fdebcecec7e51463194ea58223f739841"><img src="hurl.png" width="35"></a>.
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

Try with <a href="http://hurl.it/hurls/2c41a602a527de54dcee72c4248845eb593efffc/e667babb9a5800cfaa405e03c7b7ce0ec889f7a8"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and an array of tags in the response body.

### Roles

Freelancers have access to this resource, but will only see tags that are used in assigned projects.
