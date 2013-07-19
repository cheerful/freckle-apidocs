---
layout: default
title: User
---

# User API

## User Object Specification
<%= json :user %>

## List Users

~~~
GET /users/
~~~

### Parameters

name
: *Optional* **string**: Only users with this string in their name will be returned

email
: *Optional* **string**: only users with this string in their email address will be returned

role
: *Optional* **string**: only users with this role will be returned. Accepted values are:

    * admin
    * member
    * freelancer

state
: *Optional* **string**: only uses with this state will be returned. Accepted values are:

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

## Get the Projects a User is Participating In

~~~
GET /users/:id/participating_projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "users/:id/participating_projects" %>
<%= json :project %>

## Create a User

~~~
POST /users/
~~~

### Inputs

email
: *Required* **string**: the email address of the user.

first name
: *Optional* **string**: the first name of the user

last name
: *Optional* **string**: the last name of the user

role
: *Optional* **string**: the role for the user. Accepted values are:

    * member (**default**)
    * admin
    * freelancer

### Response

<%= headers 200 %>
<%= json :user %>

## Edit a User

~~~
PATCH /users/:id
~~~

### Inputs

email
: *Optional* **string**: the email address of the user.

first name
: *Optional* **string**: the first name of the user

last name
: *Optional* **string**: the last name of the user

role
: *Optional* **string**: the role for the user. Accepted values are:

    * member
    * admin
    * freelancer

### Response

<%= headers 200 %>
<%= json :user %>

## Resend a pending user's invitation email

~~~
PUTS /users/:id/resend_invitation_email
~~~

### Response

<%= headers 204 %>

## Activate a User

~~~
PUTS /users/:id/activate
~~~

### Response

<%= headers 204 %>

## Deactive a User

~~~
PUTS /users/:id/deactivate
~~~

### Response

<%= headers 204 %>

## Give a Freelancer Access to Projects

~~~
PUTS /users/:id/give_access_to_projects
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to give a Freelancer access to.

### Response

<%= headers 204 %>

## Revoke a Freelancer's Access to Projects

~~~
PUTS /users/:id/revoke_access_to_projects
~~~

### Inputs

projects
: *Required* **array of integers**: the IDs of the projects to revoke a Freelancer's access to.

### Response

<%= headers 204 %>

## Delete a User

~~~
DELETE /users/:id
~~~

### Response

<%= headers 204 %>