---
layout: default
title: Invoice
---

## List Invoices

~~~
GET /invoices/
~~~

### Parameters

state
: *Optional* **string**: filters by the state of the invoice. Accepted Values are:

    * `unpaid`
    * `awaiting_payment`
    * `in_progress`
    * `paid`

locked
: *Optional* **boolean**: `true` returns all invoices currently locked due to a pending paypal payment. `false` returns all invoices not currently locked

name
: *Optional* **string**: Only invoices containing this text in their name are returned.

company_name
: *Optional* **string**: Only invoices containing this text in their company name are returned.

company_details
: *Optional* **string**: Only invoices containing this text in their company details are returned.

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only invoices with a defined range from or after this date will be returned.

to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only invoices with a defined range on or before this date will be returned.

invoiced_at_from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`: Only invoices with an `invoice_date` from or after this date will be returned.

invoiced_at_to
: *Optional* **string** of a date in ISO 8061 format: `YYYY-MM-DD`. Only invoices with an `invoice_date` on or before this date will be returned.

show_hours
: *Optional* **boolean**: `true` returns all invoices that show the hours worked. `false` returns all invoices that do not show the hours worked.

show_details
: *Optional* **boolean**: `true` returns all invoices that show the invoice details. `false` returns all invoices that do not show the invocie details.

show_summaries
: *Optional* **boolean**: `true` returns all invoices that show the summary. `false` returns all invoices that do not show the summary.

payment_type
: *Optional* **string**: the payment type used for the invoices. Accepted values are:

    * `hourly`
    * `flat`

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices" %>
<%= json :invoice %>

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
: *Required* **string** in  ISO 8061 format `YYYY-MM-DD`: the date the invoice was issued.

invoice_number
: *Optional* **string**: Your identifier for the invoice. If no value is provided, then a value will be generated based on previous invoices

company_name
: *Optional* **string**: the name of the company issuing the invoice.

company_details
: *Optional* **string**: the mailing address and other information of the company issuing the invoice.

recipient
: *Optional* **string**: the mailing address and other information of the recipient of this invoice.

description
: *Optional* **string**: a description of the invoice which supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)

footer
: *Optional* **string**: the footer for the invoice's pages, which supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)

show_hours
: *Optional* **boolean**: indicates whether hours should be shown on the invoice. Defaults to `true`.

show_details
: *Optional* **boolean**: indicates whether a breakdown of all the time entries for this invoice should be included. Defaults to `false`.

show_summaries
: *Optional* **boolean**: indicates whether a summary of how many minutes time each team member worked should be included. Defaults to `false`.

payment_type
: *Optional* **hash**: The payment details used to generate the total of the invoice. The fields are:

    payment_type
    : *Optional* **string**: indicates what payment generation method will be used. Accepted values are:

        * `default` (**Default**)
        * `simple_hourly_rate`: a single hourly rate is used across the entire invoice.
        * `custom_hourly_rates`: custom hourly rates can be defined for individual users via the `custom_hourly_rates` array. If no `custom_hourly_rate` is defined for an individual user, then the `simple_hourly_rate` is used.
        * `flat_rate`: a flat rate is used for the the total cost of the hours in the invoice.

    simple_hourly_rate
    : *Required if payment_type equals `simple_hourly_rate` or `custom_hourly_rate`* **decimal**: the numerical value of the hourly rate used in this invoice.

    custom_hourly_rates
    : *Required if payment_type equals `custom_hourly_rate`* **array of hashes**: the custom hourly rate for each user that has an entry in the invoice. The fields are:

        user
        : *Required* **integer**: the ID of the user
        hourly_rate
        : *Required* **decimal**: the numerical value of the hourly rate for this specific user.

    flat_rate
    : *Required if payment_type equals `flat_rate`* **decimal**: the numerical flat rare used for the total cost of the hours in the invoice.


entries_and_expenses_selection
: *Optional* **hash**: the pattern used to select entries and expenses from our projects used in this invoice. The fields are:

    entries_and_expenses_selection
    : *Optional* **string**: the selection pattern used. Accepted values are:

        * all_uninvoiced (**Default**)
        * date_range

    from
    : *Required if entries_and_expenses_selection equals `date_range`* **string in the ISO 8061 date format `YYYY-MM-DD`

    to
    : *Required if entries_and_expenses_selection equals `date_range`* **string in the ISO 8061 date format `YYYY-MM-DD`

projects
: *Optional* **array of integers**: the indexes of projects to be included in this invoice. The projects entries will be automatically included based on the selection pattern defined in `entries_and_expenses_selection`.

entries
: *Optional* **array of integers**: the indexes of entries to be included in this invoice.

expenses
: *Optional* **array of integers**: the indexes of expenses to be included in this invoice.

include expenses
: *Optional* **boolean**: indicates whether uninvoiced expenses are included in this invoicem based on the selection pattern defined in `entries_and_expenses_selection`. Defaults to `true`.

taxes
: *Optional* **array of hashes**: the taxes to be calculated with this invoice. The fields are:

    percentage
    : *Required* **decimal**: the numeric percentage of the tax

    name
    : *Optional* **string**: the name of the tax

customization
: *Optional* **hash**: the customized labels for the invoice. Fields are:

    title
    : *Optional* **string**: The title of the Invoice. Defaults to "Invoice".

    date
    : *Optional* **string**: Label for the Invoice Date. Defaults to "Date".

    project
    : *Optional* **string**: Label for the projects associated with this invoice. Defaults to "Projects".

    reference
    : *Optional* **string**: Label associated with the Invoice Reference (Invoice Number). Defaults to "Invoice reference".

    total_due
    : *Optional* **string**: Label for the Total Amount Due on an Invoice. Defaults to "Total amount due".

    summary
    : *Optional* **string**: Label for the Summary Section of an Invoice. Defaults to "Summary".

    work_time
    : *Optional* **string**: Label for the Work Time section of an Invoice. Defaults to "work time".

    no_tax
    : *Optional* **string**: Label for the "No Tax" section of an invoice. Defaults to "no tax".

    tax
    : *Optional* **string**: Label for the Taxable section of an invoice. Defaults to "tax".

    subtotal
    : *Optional* **string**: Label for the subtotal of an invoice. Defaults to "subtotal".

    total
    : *Optional* **string**: Label for the total of an invoice. Defaults to "TOTAL".

    report
    : *Optional* **string**: Label for the Work time report section of an invocie. Defaults to "Report".

    locale
    : *Optional* **string**: The locale of the invoice. Defaults to "en-US". [View the list of supported locales]("/locales_and_currencies/#locales")

    currency_name
    : *Optional* **string**: The name of the currency. Defaults to "". [View the list of supported Currencies]("/locales_and_currencies/#currencies")

    currency_symbol
    : *Optional* **string**: The name of the currency symbol. Defaults to "$". [View the list of supported Currencies]("/locales_and_currencies/#currencies")

    taxable_total
    : *Optional* **string**: The label for the total taxable amount in the invoice. Defaults to "Total taxable".

    tax_total
    : *Optional* **string**: The label for the Total Tax Amount. Defaults to "Total tax".

    taxfree_total
    : *Optional* **string**: The label for hte total taxfree amount. Defaults to "Total taxfree".

    total_report
    : *Optional* **string**: The label for the total hours in the work report. Defaults to "TOTAL".

    custom_css
    : *Optional* **string**: Any custom CSS used in the invoice. Defaults to "".

    custom_html
    : *Optional* **string**: Any custom HTML used in the invoice. Defaults to "".

    allow_paypal_invoice
    : *Optional* **boolean**: indicates whether this invoice can be paid via paypal. Defaults to true.

    paypal_invoice_title
    : *Optional* **string**: The title for the paypal invoice. Defaults to "".

    paypal_currency_code
    : *Optional* **string**: The paypal currency code used for this invoice. Defaults to "USD". [View the list of Paypal currency codes](https://cms.paypal.com/mx/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes)

    paypal_address
    : *Optional* **string**: the email address to be paid through paypal. Defaults to "".


<%= json :invoice_create_fields %>

### Response

<%= headers 200 %>
<%= json :invoice %>

## Edit an Invoice

~~~
PATCH /invoices/:id
~~~

### Inputs

invoice_date
: *Required* **string** in  ISO 8061 format `YYYY-MM-DD`: the date the invoice was issued.

invoice_number
: *Optional* **string**: Your identifier for the invoice. If no value is provided, then a value will be generated based on previous invoices

company_name
: *Optional* **string**: the name of the company issuing the invoice.

company_details
: *Optional* **string**: the mailing address and other information of the company issuing the invoice.

recipient
: *Optional* **string**: the mailing address and other information of the recipient of this invoice.

description
: *Optional* **string**: a description of the invoice which supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)

footer
: *Optional* **string**: the footer for the invoice's pages, which supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)

show_hours
: *Optional* **boolean**: indicates whether hours should be shown on the invoice. Defaults to `true`.

show_details
: *Optional* **boolean**: indicates whether a breakdown of all the time entries for this invoice should be included. Defaults to `false`.

show_summaries
: *Optional* **boolean**: indicates whether a summary of how many minutes time each team member worked should be included. Defaults to `false`.

customization
: *Optional* **hash**: the customized labels for the invoice. Fields are:

    title
    : *Optional* **string**: The title of the Invoice. Defaults to "Invoice".

    date
    : *Optional* **string**: Label for the Invoice Date. Defaults to "Date".

    project
    : *Optional* **string**: Label for the projects associated with this invoice. Defaults to "Projects".

    reference
    : *Optional* **string**: Label associated with the Invoice Reference (Invoice Number). Defaults to "Invoice reference".

    total_due
    : *Optional* **string**: Label for the Total Amount Due on an Invoice. Defaults to "Total amount due".

    summary
    : *Optional* **string**: Label for the Summary Section of an Invoice. Defaults to "Summary".

    work_time
    : *Optional* **string**: Label for the Work Time section of an Invoice. Defaults to "work time".

    no_tax
    : *Optional* **string**: Label for the "No Tax" section of an invoice. Defaults to "no tax".

    tax
    : *Optional* **string**: Label for the Taxable section of an invoice. Defaults to "tax".

    subtotal
    : *Optional* **string**: Label for the subtotal of an invoice. Defaults to "subtotal".

    total
    : *Optional* **string**: Label for the total of an invoice. Defaults to "TOTAL".

    report
    : *Optional* **string**: Label for the Work time report section of an invocie. Defaults to "Report".

    locale
    : *Optional* **string**: The locale of the invoice. Defaults to "en-US". [View the list of supported locales]("/locales_and_currencies/#locales")

    currency_name
    : *Optional* **string**: The name of the currency. Defaults to "". [View the list of supported Currencies]("/locales_and_currencies/#currencies")

    currency_symbol
    : *Optional* **string**: The name of the currency symbol. Defaults to "$". [View the list of supported Currencies]("/locales_and_currencies/#currencies")

    taxable_total
    : *Optional* **string**: The label for the total taxable amount in the invoice. Defaults to "Total taxable".

    tax_total
    : *Optional* **string**: The label for the Total Tax Amount. Defaults to "Total tax".

    taxfree_total
    : *Optional* **string**: The label for hte total taxfree amount. Defaults to "Total taxfree".

    total_report
    : *Optional* **string**: The label for the total hours in the work report. Defaults to "TOTAL".

    custom_css
    : *Optional* **string**: Any custom CSS used in the invoice. Defaults to "".

    custom_html
    : *Optional* **string**: Any custom HTML used in the invoice. Defaults to "".

    allow_paypal_invoice
    : *Optional* **boolean**: indicates whether this invoice can be paid via paypal. Defaults to true.

    paypal_invoice_title
    : *Optional* **string**: The title for the paypal invoice. Defaults to "".

    paypal_currency_code
    : *Optional* **string**: The paypal currency code used for this invoice. Defaults to "USD". [View the list of Paypal currency codes](https://cms.paypal.com/mx/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes)

    paypal_address
    : *Optional* **string**: the email address to be paid through paypal. Defaults to "".

<%= json :invoice_edit_fields %>

### Response

<%= headers 200 %>
<%= json :invoice %>

## Get the entries in an invoice

~~~
GET /imports/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/entries" %>
<%= json :entry %>

## Add Entries to an Invoice

~~~
POST /imports/:id/entries/
~~~

### Inputs

entries
: *Required* **array of integers**: the indexes of entries to be aaded in this invoice.

### Response

<%= headers 200 %>
<%= json :entry %>

## Remove Entries from an Invoice

~~~
PUT /imports/:id/entries/
~~~

### Inputs

entries
: *Required* **array of integers**: the indexes of entries to be aaded in this invoice.

### Response

<%= headers 204 %>

## Remove all Entries from an Invoice

~~~
DELETE /imports/:id/entries/
~~~

### Response

<%= headers 204 %>

## Get the expenses in an invoice

~~~
GET /imports/:id/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/expenses" %>
<%= json :expense %>

## Add Expenses to an Invoice

~~~
POST /imports/:id/expenses/
~~~

### Inputs

expenses
: *Required* **array of integers**: the indexes of expenses to be aaded in this invoice.

### Response

<%= headers 200 %>
<%= json :expense %>

## Remove Expenses from an Invoice

~~~
PUT /imports/:id/expenses/
~~~

### Inputs

expenses
: *Required* **array of integers**: the indexes of expenses to be aaded in this invoice.

### Response

<%= headers 204 %>

## Remove all Expenses from an Invoice

~~~
DELETE /imports/:id/expenses/
~~~

### Response

<%= headers 204 %>

## Get the projects in an invoice

~~~
GET /imports/:id/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/projects" %>
<%= json :project %>

## Add Projects to an Invoice

When you add a project to the invoice, it also adds the uninvoiced entries and expenses to the project based on the parameters you have passed for `include_expenses` and `entries_and_expenses_selection`

~~~
POST /imports/:id/projects/
~~~

### Inputs

projects
: *Required* **array of integers**: the indexes of projects to be added in this invoice.

entries_and_expenses_selection
: *Optional* **hash**: the pattern used to select entries and expenses from our projects used in this invoice. The fields are:

    entries_and_expenses_selection
    : *Optional* **string**: the selection pattern used. Accepted values are:

        * all_uninvoiced (**Default**)
        * date_range

    from
    : *Required if entries_and_expenses_selection equals `date_range`* **string in the ISO 8061 date format `YYYY-MM-DD`

    to
    : *Required if entries_and_expenses_selection equals `date_range`* **string in the ISO 8061 date format `YYYY-MM-DD`

include expenses
: *Optional* **boolean**: indicates whether uninvoiced expenses are included in this invoicem based on the selection pattern defined in `entries_and_expenses_selection`. Defaults to `true`.

## Remove Projects from an Invoice

When you remove a project from the invoice, it removes the project's entries and expenses from this invoice.

~~~
PUT /imports/:id/projects/
~~~

### Inputs

projects
: *Required* **array of integers**: the indexes of projects to be aaded in this invoice.

### Response

<%= headers 204 %>

## Remove all Projects from an Invoice

When you remove all projects from the invoice, it also removes the entries and expenses from this invoice.

~~~
DELETE /imports/:id/projects/
~~~

### Response

<%= headers 204 %>

## How to change the invoice's payment type

~~~
PUT /invoices/:id/payment_type
~~~

### Input

payment_type
: *Optional* **hash**: The payment details used to generate the total of the invoice. The fields are:

    payment_type
    : *Optional* **string**: indicates what payment generation method will be used. Accepted values are:

        * `default` (**Default**)
        * `simple_hourly_rate`: a single hourly rate is used across the entire invoice.
        * `custom_hourly_rates`: custom hourly rates can be defined for individual users via the `custom_hourly_rates` array. If no `custom_hourly_rate` is defined for an individual user, then the `simple_hourly_rate` is used.
        * `flat_rate`: a flat rate is used for the the total cost of the hours in the invoice.

    simple_hourly_rate
    : *Required if payment_type equals `simple_hourly_rate` or `custom_hourly_rate`* **decimal**: the numerical value of the hourly rate used in this invoice.

    custom_hourly_rates
    : *Required if payment_type equals `custom_hourly_rate`* **array of hashes**: the custom hourly rate for each user that has an entry in the invoice. The fields are:

        user
        : *Required* **integer**: the ID of the user
        hourly_rate
        : *Required* **decimal**: the numerical value of the hourly rate for this specific user.

    flat_rate
    : *Required if payment_type equals `flat_rate`* **decimal**: the numerical flat rare used for the total cost of the hours in the invoice

### Response

<%= headers 204 %>

## Add Custom Hourly Rates

When a custom hourly rate is added, it changes the `payment_type` to `custom_hourly_rates`

~~~
POST /imports/:id/custom_hourly_rates
~~~

### Inputs

custom_hourly_rates
: *Required* **array of hashes**: the custom hourly rate for each user that has an entry in the invoice. The fields are:

    user
    : *Required* **integer**: the ID of the user
    hourly_rate
    : *Required* **decimal**: the numerical value of the hourly rate for this specific user.

simple_hourly_rate
    : *Required* **decimal**: the numerical value of the hourly rate used if a user does not have a custom hourly rate.

### Response

<%= headers 204 %>

## Remove Custom Hourly Rates

~~~
PUT /imports/:id/custom_hourly_rates
~~~

### Inputs

custom_hourly_rates
: *Required* **array of integers**: the IDs of each custom hourly rate to remove.

### Response

<%= headers 204 %>

## Remove all Custom Hourly Rates

Remove all custom hourly rates from an invoice

~~~
DELETE /imports/:id/custom_hourly_rates
~~~

### Response

<%= headers 204 %>

## Add Taxes to an Invoice

~~~
POST /imports/:id/taxes/
~~~

### Inputs

taxes
: *Required* **array of hashes**: the taxes to be added to this invoice. The fields are:

    percentage
    : *Required* **decimal**: the numeric percentage of the tax

    name
    : *Optional* **string**: the name of the tax


## Remove Taxes from an Invoice

~~~
PUT /imports/:id/taxes/
~~~

### Inputs

taxes
: *Required* **array of integers**: the indexes of taxes to be removed from this invoice.

### Response

<%= headers 204 %>

## Remove all Taxes in Invoice

Removes all taxes from an invoice.

~~~
DELETE /imports/:id/taxes/
~~~

### Response

<%= headers 204 %>

## Delete an Invoice

~~~
DELETE /invoices/:id
~~~

### Response

<%= headers 204 %>

### a note about invoice deletion

An invoice can only be deleted if it has not been paid yet. When an invoice is deleted, all of the entries and expenses associated with it are marked as uninvoiced.

The error code used to indicate that an invoice has been paid is: **paid**.