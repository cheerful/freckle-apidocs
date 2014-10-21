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

    * admin
    * member
    * freelancer

state
: *Optional* **string**
: Only users with this state will be returned. Accepted values are:

    * disabled
    * pending
    * active
    * suspended

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users" %>
<%= json :user %>

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
<%= json :entry %>

## Get a User's Expenses

~~~
GET /users/:id/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users/:id/expenses" %>
<%= json :expense %>

## Get the Projects the User has logged entries or expenses for

~~~
GET /users/:id/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users/:id/projects" %>
<%= json :project %>

## Create a User

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
: The user's role. Accepted values are:

    * member (**default**)
    * admin
    * freelancer

### Response

<%= headers 200 %>
<%= json :user %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **reached_user_limit**: the account has reached the maximum number of active users available for the current plan. The account owner will have to [upgrade their account](http://help.letsfreckle.com/accounts-billing/upgrading-downgrading).

## Edit a User

~~~
PUT /users/:id
~~~

### Inputs

email
: *Optional* **string**
: The email address of the user.

first name
: *Optional* **string**
: The first name of the user

last name
: *Optional* **string**
: The last name of the user

role
: *Optional* **string**
: The user's role. Accepted values are:

    * member
    * admin
    * freelancer

### Response

<%= headers 200 %>
<%= json :user %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **deactivated**: The user is deactivated, and therefore cannot be edited until it is reactivated.

## Resend a pending user's invitation email

This action re-sends the invitation email for a pending user. This email allows pending users to set their password and start using Freckle.

~~~
PUT /users/:id/resend_invitation_email
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **not_pending**: The user is not pending, meaning that they cannot be sent an invitiation email. This is usually because the user has used a previous invitation email to set their password and start using Freckle.

## Reactivate a Deactivated User

This action reactivates a previously deactivated user, which allows the user to start using Freckle again.

~~~
PUT /users/:id/activate
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **not_deactivated**: The user is not deactivated, and therefore cannot be reactivated.

## Give a Freelancer Access to Projects

Giving a Freelancer Access to a project allows them to view and create entries and expenses for the project. Any projects the user already has access to are ignored.

~~~
PUT /users/:id/give_access_to_projects
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to give a Freelancer access to.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **not_a_freelancer**: The user is not a freelancer
* **already_has_access**: The user already has access to this project
* **deactivated**: The user is deactivated, and therefore cannot be given access to any projects.

## Revoke a Freelancer's Access to Projects

Revoking a Freelancer's access to a project prevents them from viewing the entries and expenses for the project. Note that the freelancer's entries and expenses logged for the project **are not deleted**. Any projects that the user does not have access to are ignored.

~~~
PUT /users/:id/revoke_access_to_projects
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to revoke a Freelancer's access to.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **not_a_freelancer**: The user is not a freelancer
* **deactivated**: The user is deactivated, and therefore cannot be modified.

## Delete a User

~~~
DELETE /users/:id
~~~

### Response

<%= headers 204 %>

### A note about user deletion

A user cannot be deleted if there are any entries this user.

You can deactivate the user, which will remove this user from the list of active users and increment the number of available users available until the account limit is reached.

The error message for the delete action follows the pattern explained in the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources), but instead of using an "Archive" action, the [Disable](#disable) action is used.

## Deactive a User

~~~
PUT /users/:id/deactivate
~~~

### Response

<%= headers 204 %>

### A note about user deactivation

A user cannot be deactivated if there are no entries associated with this user. Instead, you can only delete the user.

For more information about how deleting a user works, please the API basics section on [Deleting or Archiving Resources](/#deleting-or-archiving-resources)