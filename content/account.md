---
layout: default
title: Account
---

## Account Object Specification

<%= json :account %>

## Get your Account's details

~~~
GET /account/
~~~

### Response
<%= headers 200 %>
<%= json :account %>

## Edit your Account's details

~~~
PATCH /account/
~~~

### Input

title
: *Optional* **string**: the Title used in your account.

address
: *Optional* **object**: The address fields used as the contact information for the invoice. The accepted fields are:

	address1
	: *Optional* **string**: the first part of the mailing address

	address2
	: *Optional* **string**: the second part of the mailing address

	city
	: *Optional* **string**

	state
	: *Optional* **string**

	zip
	: *Optional* **string**

	country
	: *Optional* **string**

	phone
	: *Optional* **string**

<%= json :account_editable_fields %>

### Response
<%= headers 200 %>
<%= json :account %>