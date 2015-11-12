---
layout: v2
title: Expenses
---

* TOC
{:toc}

## List Expenses

Get all the expenses, sorted by the most recent date.

~~~
GET /v2/expenses
~~~

### Parameters

Each parameter passed will filter the results, and parameters are chained (meaning that if you search by `user_ids` and `project_ids`, it will only return expenses from those users for the specified projects).

user_ids
: *Optional* **string**: a comma-separated list of user IDs to filter by.
: Example: `user_ids=1,2,3`

description
: *Optional* **string**
: Only expenses containing this text in their description are returned.
: Example: `description=license`

project_ids
: *Optional* **string**: a comma-separated list of project IDs to filter by.
: Example: `project_ids=4,5,6`

invoice_ids
: *Optional* **string**: a comma-separated list of invoices to filter by
: Example: `invoice_ids=4,5,6`

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only expenses from or after this date will be returned.

to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only expenses on or before this date will be returned.

price_from
: *Optional* **decimal**
: Only expenses with a price greater than or equal to this will be returned

price_to
: *Optional* **decimal**
: Only expenses with a price less than or equal to this will be returned

taxable
: *Optional* **boolean**: `true` only shows expenses where taxes are applied, `false` only shows expenses were taxes are not applied.

invoiced
: *Optional* **boolean**
: `true`: only show invoiced expenses
: `false`: only shows uninvoiced expenses

### Response

<%= headers 200, :pagination => true, :pagination_resource => "expenses" %>
<%= json_array :expense %>

## Get a single Expense

~~~
GET /v2/expenses/:id
~~~

<%= headers 200 %>
<%= json :expense %>

## Create an Expense

~~~
POST /v2/expenses
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the expense.

project_id
: *Required* **integer**: The ID of the project this expense is for.

price
: *Required* **decimal**: The numeric price of this expense. **Do not add the currency to this price**. Note that the price can be negative

user_id
: *Optional* **integer**: The ID of the user who created this expense. If no value is provided, the authenticated user will be used.

taxable
: *Optional* **boolean**: `true` indicates that the expense is taxable. `false` indicates that the expense is tax-free. Defaults to `true`.

description
: *Optional* **string**: The description of the expense. Note that tags or hashtags will not be parsed.

<%= json :expense_editable_fields %>

### Reponse

<%= headers 201, :Location => "#{API_V2_URL}/expenses/1" %>
<%= json :expense %>

## Edit an Expense

~~~
PUT /v2/expenses/:id
~~~

### Input

date
: *Required* **string** of a date in ISO 8061 format `YYY-MM-DD`: the date of the expense.

project_id
: *Required* **integer**: The ID of the project this expense is for.

price
: *Required* **decimal**: The numeric price of this expense. **Do not add the currency to this price**. Note that the price can be negative

user_id
: *Optional* **integer**: The ID of the user who created this expense. If no value is provided, the authenticated user will be used.

taxable
: *Optional* **boolean**: `true` indicates that the expense is taxable. `false` indicates that the expense is tax-free. Defaults to `true`.

description
: *Optional* **string**: The description of the expense. Note that tags or hashtags will not be parsed.

<%= json :expense_editable_fields %>

### Response

<%= headers 200 %>
<%= json :expense %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invoiced**: the expense has been invoiced
* **archived_project**: the expense is associated with an archived project

## Delete an Expense

~~~
DELETE /v2/expenses/:id
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invoiced**: the expense has been invoiced
* **archived_project**: the expense is associated with an archived project