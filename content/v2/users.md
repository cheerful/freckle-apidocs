---
layout: default
title: User
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## List Users

~~~
GET /users/
~~~

### Parameters

name
: *Optional* **string**
: Only users with this string in their name are returned.
: Example: `name=John`

email
: *Optional* **string**
: Only users with this string in their email address are returned.
: Example: `email=mary`

role
: *Optional* **string**
: Only users with this role will be returned. Accepted values are:

    * supervisor
    * leader
    * coworker
    * contractor

state
: *Optional* **string**
: Only users with this state will be returned. Accepted values are:

    * disabled
    * pending
    * active
    * suspended

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users" %>
<%= json_array :user %>

## Get a single user

~~~
GET /users/:id
~~~

### Response

<%= headers 200 %>
<%= json :user %>

## Get a User's Entries

~~~
GET /users/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users/:id/entries" %>
<%= json_array :entry %>

## Get a User's Expenses

~~~
GET /users/:id/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users/:id/expenses" %>
<%= json_array :expense %>

## Create a User

<p class="note warning">For accounts with subscriptions that include per-user pricing, calling this action may change the billing amount total for the next monthly billing cycle and/or change the next billing date if there is an active prepayment for this Freckle account.</p>

~~~
POST /users/
~~~

### Inputs

email
: *Required* **string**
: The email address of the user.

first name
: *Optional* **string**
: The first name of the user.

last name
: *Optional* **string**
: The last name of the user.

role
: *Optional* **string**
: The user's [role](http://help.letsfreckle.com/article/86-setting-permissions). Accepted values are:

    * supervisor
    * leader (**default**)
    * coworker
    * contractor

### Response

<%= headers 201, :Location => "#{API_V2_URL}/users/1"  %>
<%= json :user %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **reached_user_limit**: the account has reached the maximum number of active users available for the current plan. The account owner will have to [upgrade their account](http://help.letsfreckle.com/article/69-upgrading-and-downgrading-your-account).

## Edit a User

<p class="note warning">For accounts with subscriptions that include per-user pricing, calling this action may change the billing amount total for the next monthly billing cycle and/or change the next billing date if there is an active prepayment for this Freckle account.</p>

~~~
PUT /users/:id
~~~

### Inputs

first name
: *Optional* **string**
: The first name of the user

last name
: *Optional* **string**
: The last name of the user

role
: *Optional* **string**
: The user's [role](http://help.letsfreckle.com/article/86-setting-permissions). Accepted values are:

    * supervisor
    * leader
    * coworker
    * contractor

### Response

<%= headers 200 %>
<%= json :user %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **deactivated**: The user is deactivated, and therefore cannot be edited until they are reactivated.
* **authenticated_user**: Authenticated users cannot change certain properties about themselves.

## Reactivate a Deactivated User

This action reactivates a previously deactivated user, which allows the user to start using Freckle again.

<p class="note warning">For accounts with subscriptions that include per-user pricing, calling this action may change the billing amount total for the next monthly billing cycle and/or change the next billing date if there is an active prepayment for this Freckle account.</p>

~~~
PUT /users/:id/activate
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **not_deactivated**: The user is not deactivated, and therefore cannot be reactivated.
* **reached_user_limit**: the account has reached the maximum number of active users available for the current plan. The account owner will have to [upgrade their account](http://help.letsfreckle.com/article/69-upgrading-and-downgrading-your-account).

## Give a User Access to Projects

<div class="note">Currently, only freelancers are affected by project access rules.</div>

Giving a User Access to a project allows them to view and create entries and expenses for the project. Any projects the user already has access to are ignored.

~~~
PUT /users/:id/give_access_to_projects
~~~

### Inputs

project_ids
: *Required* **array of integers**: the IDs of the projects to give a User access to.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **deactivated**: The user is deactivated, and therefore cannot be given access to any projects.
* **authenticated_user**: Authenticated users cannot change their project access rules.

### A note about projects that the user cannot be given access to

Any projects are included in this request that the user cannot be given access to will be ignored and will not affect the Response.

## Revoke a User's Access to Projects

<div class="note">Currently, only freelancers are affected by project access rules.</div>

Revoking a User's access to a project prevents them from viewing the entries and expenses for the project. Note that the user's entries and expenses logged for the project **are not deleted**. Any projects that the user does not have access to are ignored.

~~~
PUT /users/:id/revoke_access_to_projects
~~~

### Inputs

project_ids
: *Required* **array of integers**: the IDs of the projects to revoke a User's access to.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **can_access_all_projects**: The user is has access all the projects in this account, and cannot be prevented from accessing specific projects.
* **deactivated**: The user is deactivated, and therefore cannot be modified.
* **authenticated_user**: Authenticated users cannot change their project access rules.

## Revoke a user's access to all projects

<div class="note">Currently, only freelancers are affected by project access rules.</div>

~~~
PUT /users/:id/revoke_access_to_all_projects
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **can_access_all_projects**: The user is has access all the projects in this account, and cannot be prevented from accessing specific projects.
* **deactivated**: The user is deactivated, and therefore cannot be modified.
* **authenticated_user**: Authenticated users cannot change their project access rules.

## Delete a User

<p class="note warning">For accounts with subscriptions that include per-user pricing, calling this action may change the billing amount total for the next monthly billing cycle and/or change the next billing date if there is an active prepayment for this Freckle account.</p>

~~~
DELETE /users/:id
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **account_owner**: Account owners cannot be deleted
* **authenticated_user**: Authenticated users cannot delete themselves.
* **not_deletable**: the User cannot be deleted because they have entries


### A note about user deletion

A user cannot be deleted if there are any entries associated with this user.

You can deactivate the user, which will remove this user from the list of active users and increment the number of available users available until the account limit is reached.

For more information about how deleting and archiving a user works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)

## Deactivate a User

<p class="note warning">For accounts with subscriptions that include per-user pricing, calling this action may change the billing amount total for the next monthly billing cycle and/or change the next billing date if there is an active prepayment for this Freckle account.</p>

~~~
PUT /users/:id/deactivate
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **account_owner**: Account owners cannot be deactivated
* **authenticated_user**: Authenticated users cannot deactivate themselves.
* **deletable**: the user should be deleted because they do not have any entries

### A note about user deactivation

A user cannot be deactivated if there are no entries associated with this user. Instead, you can only delete the user.

For more information about how deleting a user works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)