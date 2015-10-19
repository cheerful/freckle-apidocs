---
layout: default
title: Account
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

## Get your Account's details

~~~
GET /account/
~~~

### Response
<%= headers 200 %>
<%= json :account %>