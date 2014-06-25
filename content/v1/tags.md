---
layout: v1
title: Tags
description: Access Tags with the Freckle Time Tracking RESTful API.
---

Currently the only available tags API method is listing tags.

## List tags

    GET /api/tags

The tags resource returns all tags for the account.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/tags.json
<%= code_block_end_tag %>

Response:

<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/684cc1abac7137e24757f6f75cbbd16e3d20e6f4/43ef044616088dee5cbb94e4e254271c40120908"><img src="/assets/hurl.png" alt="hurl" width="35"></a>.
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/tags.xml
<%= code_block_end_tag %>

Response:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;tags</span> <span class="na">type=</span><span class="s">&quot;array&quot;</span><span class="nt">&gt;</span>
  <span class="nt">&lt;tag&gt;</span>
    <span class="nt">&lt;account-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5039<span class="nt">&lt;/account-id&gt;</span>
    <span class="nt">&lt;billable</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/billable&gt;</span>
    <span class="nt">&lt;created-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2010-06-09T20:44:57Z<span class="nt">&lt;/created-at&gt;</span>
    <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>55629<span class="nt">&lt;/id&gt;</span>
    <span class="nt">&lt;import-id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/import-id&gt;</span>
    <span class="nt">&lt;name&gt;</span>a<span class="nt">&lt;/name&gt;</span>
    <span class="nt">&lt;updated-at</span> <span class="na">type=</span><span class="s">&quot;date time&quot;</span><span class="nt">&gt;</span>2010-06-09T20:44:57Z<span class="nt">&lt;/updated-at&gt;</span>
  <span class="nt">&lt;/tag&gt;</span>
  <span class="c">&lt;!-- ...more tags... --&gt;</span>
<span class="nt">&lt;/tags&gt;</span>
</code></pre>
</div>

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/32172677f730772b2bf29ed8c816fc00dd7277ef/05ceba40a58d8800d6b2a0be136dbaee6a1f4a8d"><img src="/assets/hurl.png" alt="hurl" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and an array of tags in the response body.

### Roles

Freelancers have access to this resource, but will only see tags that are used in assigned projects.
