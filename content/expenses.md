---
layout: default
title: Expense
---

## Expense Object Specification
<%= json :expense %>

## List Expenses

Get all the expenses, sorted by the most recent date.

~~~
GET /expenses/
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `users` and `projects`, it will only return expenses from those users for the specified projects).

users
: *Optional* **string**: a comma-separated list of user IDs to filter by.
Example: `users=1,2,3`

projects
: *Optional* **string**: a comma-separated list of project IDs to filter by.
Example: `projects=4,5,6`

invoices
: *Optional* **string**: a comma-separated list of invoices to filter by

imports
: *Optional* **string**: a comma-separated list of imports to filter by

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only expenses from or after this date will be returned.

to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only expenses on or before this date will be returned.

apply_taxes
: *Optional* **boolean**: `true` only shows expenses where taxes are applied, `false` only shows expenses were taxes are not applied.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "expenses" %>
<%= json :expense %>

## Get a single Expense

~~~
GET /expenses/:id
~~~

<%= headers 200 %>
<%= json :expense %>

## Create an Expense

~~~
POST /expenses/
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the expense.

user
: *Optional* **integer**: The ID of the user who created this expense. If no value is provided, the authenticated user will be used.

price
: *Required* **decimal**: The numeric price of this expense. **Do not add the currency to this price**.

apply_tax
: *Optional* **boolean**: `true` indicates that the expense is taxable. `false` indicates that the expense is tax-free. Defaults to `true`.

description
: *Optional* **string**: The description of the expense. Note that tags or hashtags will not be parsed.

project
: *Required* **integer**: The ID of the project this expense is for.

<%= json :expense_editable_fields %>

### Reponse

<%= headers 201, :Location => "https://apitest.letsfreckle.com/api/v2/expenses/1" %>
<%= json :expense %>

## Edit an Expense

~~~
PATCH /expenses/:id
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the expense.

user
: *Optional* **integer**: The ID of the user who created this expense. If no value is provided, the authenticated user will be used.

price
: *Required* **decimal**: The numeric price of this expense. **Do not add the currency to this price**.

apply_tax
: *Optional* **boolean**: `true` indicates that the expense is taxable. `false` indicates that the expense is tax-free. Defaults to `true`.

description
: *Optional* **string**: The description of the expense. Note that tags or hashtags will not be parsed.

project
: *Required* **integer**: The ID of the project this expense is for.

<%= json :expense_editable_fields %>

### Response

<%= headers 200 %>
<%= json :expense %>

## Delete an Expense

~~~
DELETE /expenses/:id
~~~

### Response

<%= headers 204 %>