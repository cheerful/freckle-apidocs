---
layout: default
title: Invoice
---

* TOC
{:toc}

## List Invoices

~~~
GET /invoices/
~~~

### Parameters

state
: *Optional* **string**
: Only invoices in this state will be returned. Accepted Values are:

    * `unpaid`
    * `awaiting_payment`
    * `in_progress`
    * `paid`
    * `none`

reference
: *Optional* **string**
: Only invoices containing this text in their invoice reference are returned.
: Example: `reference=AA001`

invoice_date_from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only invoices with an `invoice_date` from this date forward will be returned.
: Example: `from=2013-09-27`

invoice_date_to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only invoices with an `invoice_date` on or before this date will be returned.
: Example: `to=2013-09-27`

project_name
: *Optional* **string**
: Only invoices containing this text in their `project_name` field are returned.
: Example: `project_name=Invoice`

total_amount_from
: *Optional* **decimal**
: Only invoices with a total amount due greater than or equal to this will be returned

total_amount_to
: *Optional* **decimal**
: Only invoices with a total amount due less than or equal to this will be returned

recipient_details
: *Optional* **string**
: Only invoices containing this text in their `recipient_details` field are returned.
: Example: `recipient_details=Furniture`

project_ids
: *Optional* **string**
: A comma-separated list of project IDs to filter by.
: Example: `project_ids=4,5,6`

company_name
: *Optional* **string**
: Only invoices containing this text in their `company_name` field are returned.
: Example: `company_name=Gear`

company_details
: *Optional* **string**
: Only invoices containing this text in their `company_details` field are returned.
: Example: `company_details=Main`

description
: *Optional* **string**
: Only invoices containing this text in their `description` field are returned
: Example: `description=Services`

footer
: *Optional* **string**
: Only invoices containing this text in their `footer` field are returned
: Example: `footer=Payment`

has_online_payment_details
: *Optional* **boolean**
: `true`:  Only return invoices that have online payment details.
: `false`: Only return invoices that do not have online payment details.

has_custom_html
: *Optional* **boolean**
: `true`:  Only return invoices that include custom HTML.
: `false`: Only return invoices that do not include custom HTML.

show_hours_worked
: *Optional* **boolean**
: `true`:  Only return invoices that show the hours worked for this invoice.
: `false`: Only return invoices that do not show the hours worked for this invoice.

show_full_report
: *Optional* **boolean**
: `true`:  Only return invoices that show the full report for the invoice.
: `false`: Only return invoices that do not show the full report for the invoice.

show_user_summaries
: *Optional* **boolean**
: `true`:  Only return invoices that show the summary of hours worked for each team member.
: `false`: Only return invoices that do not show the summary of hours worked for each team member.

show_project_summaries
: *Optional* **boolean**
: `true`: Only return invoices that show the summary of hours worked for each project.
: `false`: Only return invoices that do not show the summary of hours worked for each project.

show_project_name_for_expenses
: *Optional* **boolean**
: `true`: Only return invoices that show the expense's project name next to the expense description.
: `false`: Only return invoices that do not show the expense's project name next to the expense description.

locale
: *Optional* **string**
: Only invoices using this locale are returned.
: Accepted values: ([Any of the supported locale codes](/invoice_locales/#locales))
: Example: `locale=en-GB`

currency_code
: *Optional* **name**
: Only invoices using this currency are returned
: Accepted values: ([Any of the supported ISO currency codes](/invoice_locales/#currencies))
: Example: `currency_code=EUR`

currency_symbol
: *Optional* **string**
: Only invoices with this text as part of their `currency_symbol` are returned
: Example: `currency_symbol=£`

rate_calculation
: *Optional* **string**
: How the rate for the hours worked is calculated. The Accepted values are:

    * `custom_hourly_rates`
    * `standard_hourly_rate`
    * `flat_rate`

updated_from
: *Optional* **string** of a timestamp in ISO 8061 format `YYYY-MM-DDTHH:MM:SSZ`
: Only invoices updated from or after this timestamp will be returned.
: Example: `updated_from=2012-01-09T08:33:29Z`

updated_to
: *Optional* **string** of a timestamp in ISO 8061 format `YYYY-MM-DDTHH:MM:SSZ`
: Only invoices updated on or before this timestamp will be returned.
: Example: `updated_to=2012-01-09T08:33:29Z`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices" %>
<%= json_array :invoice %>

## Get a single Invoice

~~~
GET /invoices/:id
~~~

### Response

<%= headers 200 %>
<%= json :invoice %>

## Create an Invoice

~~~~
POST /invoices/
~~~~

### Input

invoice_date
: *Required* **string** in  ISO 8061 format `YYYY-MM-DD`
: The date the invoice was issued.

<%= render 'invoice_details_fields' %>
<%= render 'invoice_rate_calculation_fields' %>

entry_ids
: *Optional* **array of integers**
: The IDs of the entries to be included in this invoice.

expense_ids
: *Optional* **array of integers**
: The IDs of the expenses to be included in this invoice.

taxes
: *Optional* **array of objects**
: The taxes to apply to this invoice. The fields are:

    percentage
    : *Required* **decimal** in percentage format (`00.00`)
    : the numeric percentage of the tax

    name
    : *Optional* **string**
    : the name of the tax

<%= render 'invoice_customization_fields' %>

<%= json :invoice_create_fields %>

### Response

<%= headers 201, :Location => "#{API_V2_URL}/invoices/1"  %>
<%= json :invoice %>

### A note about entries or expenses that cannot be added

If entries or expenses cannot be added to an invoice, the invoice will not be created and an itemized errors array will be returned.

<%= headers 400 %>
<%= json :invoice_entries_and_expenses_error_example %>

### Custom Error Codes

* **locale_not_available**: The given locale is not a [Supported locale code](/locales_and_currencies/#locales)

## Edit an Invoice

~~~
PUT /invoices/:id
~~~

### Inputs

invoice_date
: *Optional* **string** in  ISO 8061 format `YYYY-MM-DD`
: The date the invoice was issued.

<%= render 'invoice_details_fields' %>

<%= render 'invoice_rate_calculation_fields' %>

<%= render 'invoice_customization_fields' %>

<%= json :invoice_edit_fields %>

### Response

<%= headers 200 %>
<%= json :invoice %>

### Custom Error Codes

* **locale_not_available**: The given locale is not a [Supported locale code](/locales_and_currencies/#locales)
* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Mark an Invoice as paid

~~~
PUT /invoices/:id/paid
~~~

### Response

<%= headers 204 %>


## Mark an Invoice as unpaid

~~~
PUT /invoices/:id/unpaid
~~~

### Response

<%= headers 204 %>

## Get the invoice's entries

~~~
GET /invoices/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/entries" %>
<%= json :entry %>

## Get the invoice's expenses

~~~
GET /invoices/:id/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/expenses" %>
<%= json :expense %>

## Add Entries to an Invoice

~~~
PUT /invoices/:id/add_entries
~~~

### Inputs

entry_ids
: *Required* **array of integers**
: the IDs of the entries to add to this invoice.

### Response

<%= headers 204 %>

### A note about entries that cannot be added

If entries cannot be added to an invoice, the invoice will not be created and an itemized errors array will be returned.

<%= headers 400 %>
<%= json :invoice_entries_error_example %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove Entries from an Invoice

~~~
PUT /invoices/:id/remove_entries
~~~

### Inputs

entry_ids
: *Required* **array of integers**
: the IDs of the entries to remove from this invoice. Any entries that are not associated with the invoice will be ignored and will not affect the Response.

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove all Entries from an Invoice

~~~
PUT /invoices/:id/remove_all_entries
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Add Expenses to an Invoice

~~~
PUT /invoices/:id/add_expenses
~~~

### Inputs

expense_ids
: *Required* **array of integers**
: the IDs of the expenses to add to this invoice.

### Response

<%= headers 204 %>

### A note about entries that cannot be added

If entries cannot be added to an invoice, the invoice will not be created and an itemized errors array will be returned.

<%= headers 400 %>
<%= json :invoice_entries_error_example %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove Expenses from an Invoice

~~~
PUT /invoices/:id/remove_expenses
~~~

### Inputs

expense_ids
: *Required* **array of integers**
: the IDs of the expenses to remove from this invoice. Any expenses that are not associated with this invoice will be ignored and will not affect the Response.

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove all Expenses from an Invoice

~~~
PUT /invoices/:id/remove_all_expenses
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Add Taxes to an Invoice

~~~
PUT /invoices/:id/add_taxes
~~~

### Inputs

taxes
: *Required* **array of objects**
: the taxes to add to this invoice. The fields are:

    percentage
    : *Required* **decimal** in percentage format (`00.00`)
    : the numeric percentage of the tax

    name
    : *Optional* **string**
    : the name of the tax


### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove Taxes from an Invoice

~~~
PUT /invoices/:id/remove_taxes
~~~

### Inputs

tax_ids
: *Required* **array of integers**
: the IDs of taxes to remove from this invoice. Any taxes that are not associated with this invoice will be ignored.

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Remove all Taxes from an Invoice

~~~
PUT /invoices/:id/remove_all_taxes
~~~

### Response

<%= headers 204 %>

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid

## Delete an Invoice

~~~
DELETE /invoices/:id
~~~

### Response

<%= headers 204 %>

### A note about invoice deletion

When an invoice is deleted, the entries and expenses associated with that tag are marked as uninvoiced. An invoice cannot be deleted if it has been paid or is locked for payment.

### Custom Error Codes

* **paid**: the Invoice has been paid
* **locked**: the Invoice is locked while it is being paid