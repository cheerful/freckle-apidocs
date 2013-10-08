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
: *Optional* **string**
: Only invoices in this state will be returned. Accepted Values are:

    * `unpaid`
    * `awaiting_payment`
    * `in_progress`
    * `paid`

name
: *Optional* **string**
: Only invoices containing this text in their `name` field are returned.
: Example: `name=Invoice`

company_name
: *Optional* **string**
: Only invoices containing this text in their `company_name` field are returned.
: Example: `company_name=Gear`

company_details
: *Optional* **string**
: Only invoices containing this text in their `company_details` field are returned.
: Example: `company_details=Main`

from
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only invoices with an `invoice_date` from this date forward will be returned.
: Example: `from=2013-09-27`

to
: *Optional* **string** of a date in ISO 8061 format `YYYY-MM-DD`
: Only invoices with an `invoice_date` on or before this date will be returned.
: Example: `to=2013-09-27`

show_hours
: *Optional* **boolean**
: `true`:  Only return invoices that show the hours worked for this invoice.
: `false`: Only return invoices that do not show the hours worked for this invoice.

show_details
: *Optional* **boolean**
: `true`:  Only return invoices that show the details for the invoice.
: `false`: Only return invoices that do not show the details for the invoice.

show_summaries
: *Optional* **boolean**
: `true`  Only return invoices that show the summary of hours worked for each time member.
: `false` Only return invoices that do not show the summary of hours worked for each time member.

payment_type
: *Optional* **string**
: The payment type used for the invoices. The Accepted values are:

    * `custom_hourly_rates`
    * `simple_hourly_rate`
    * `flat_rate`

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
: *Required* **string** in  ISO 8061 format `YYYY-MM-DD`
: the date the invoice was issued.

invoice_number
: *Optional* **string**
: Your identifier for the invoice. If no value is provided, then a value will be generated based on previous invoices

company_name
: *Optional* **string**
: the name of the company issuing the invoice.

company_details
: *Optional* **string**
: the mailing address and other information of the company issuing the invoice.

recipient
: *Optional* **string**
: the mailing address and other information invoice's recipient.

description
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices))
: a description of the invoice.

footer
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)
: the footer for each page of the invoice.

show_hours
: *Optional* **boolean**
: `true` (**Default**): The hours worked will be shown when viewing the invoice
: `false`: The hours worked will not be shown when viewing the invoice.

show_details
: *Optional* **boolean**
: `true`: The details for this invoice will be shown when viewing the invoice.
: `false` (**Default**): The details for this invoice will not be shown when viewing the invoice.

show_summaries
: *Optional* **boolean**
: `true`: a summary of how many minutes each team member worked will be shown when viewing the invoice.
: `false` (**Default**): a summary of how many minutes each team member worked will not be shown when viewing the invoice.

hours_calculation
: *Optional* **object**
: The details of how to calculate the total dollar amount for hours worked. The fields are:

    calculation_method
    : *Optional* **string**
    : indicates what method will be used to calculate the total dollar amount for hours worked. Accepted values are:

        * `simple_hourly_rate`: a single hourly rate is used for across the entire invoice.
        * `custom_hourly_rates`: custom hourly rates can be defined for individual users via the `custom_hourly_rates` array. If no `custom_hourly_rate` is defined for an individual user, then the `simple_hourly_rate` is used for that user.
        * `flat_rate`: a flat rate is used for the the total cost of the hours in the invoice.

    simple_hourly_rate
    : *Required if `calculation_method` equals `simple_hourly_rate` or `custom_hourly_rate`* **decimal**
    : the hourly rate used in this invoice.

    custom_hourly_rates
    : *Required if `calculation_method` equals `custom_hourly_rate`* **array of objects**
    : the custom hourly rates for users, which are used to calculate the total dollar amount for the hours they worked in this invoice. The fields are:

        user
        : *Required* **integer**
        : the ID of the user

        hourly_rate
        : *Required* **decimal**
        : the hourly rate for this specific user.

    flat_rate
    : *Required if payment_type equals `flat_rate`* **decimal**
    : The flat rate used as the total dollar amount for hours worked.


entries_and_expenses_selection
: *Optional* **object**
: The details of how to automatically select entries and expenses from the projects included in this invoice. The fields are:

    selection_rules
    : *Optional* **string**
    : the selection pattern used. Accepted values are:
        * `all_uninvoiced` (**Default**): All uninvoiced entries and expenses will be included.
        * `date_range`: Only entries and expenses in this specific date range will be returned.
        * `none`: Do not search for any uninvoiced entries and expenses.

    from
    : *Required if entries_and_expenses_selection equals `date_range`* **string** in the ISO 8061 date format `YYYY-MM-DD`
    : Entries and Expenses from this date forward will be included in this invoice.

    to
    : *Required if entries_and_expenses_selection equals `date_range`* **string** in the ISO 8061 date format `YYYY-MM-DD`
    : Entries and Expenses on or before this date will be included in this invoice.

    include expenses
    : *Optional* **boolean**
    : `true` (*Default*): Uninvoiced expenses found using this selection rule are included in the invoice.
    : `false`: Uninvoiced expenses found using this selection rule are not included in the invoice.

projects
: *Optional* **array of integers**
: The IDs of the projects to be included in this invoice. The projects' entries will be automatically included based on the details of the `entries_and_expenses_selection` object. If `entries_and_expenses_selection` is not defined, then all uninvoiced entries and expenses from these projects will be automatically included.

entries
: *Optional* **array of integers**
: The IDs of specific entries to be included in this invoice. You can include specific entries along with using the `entries_and_expense_selection` object to get additional entries. Note that if the entry's project is not included in the `projects` array, it will automatically added when creating the invoice and additional entries and expenses will be found using the `entries_and_expenses_selection` object.

expenses
: *Optional* **array of integers**
: The IDs of specific expenses to be included in this invoice. You can include specific expenses along with using the `entries_and_expense_selection` object to get additional expenses. Note that if the expense's project is not included in the `projects` array, it will automatically added when creating the invoice and additional entries and expenses will be found using the `entries_and_expenses_selection` object.

taxes
: *Optional* **array of objects**
: Each object represents a tax that will be applied to this invoice. The fields are:

    percentage
    : *Required* **decimal** in percentage format (`00.00`)
    : the numeric percentage of the tax

    name
    : *Optional* **string**
    : the name of the tax

customization
: *Optional* **object**
: The values in these fields are used a labels when viewing an invoice, modify how the invoice's values are displayed due to localization, or specify how the invoice is payable via Paypal. The fields are:

    title
    : *Optional* **string**
    : The title of the Invoice. Defaults to "Invoice".

    date
    : *Optional* **string**
    : The label for the Invoice Date. Defaults to "Date".

    project
    : *Optional* **string**
    : The label for the list of projects associated with this invoice. Defaults to "Projects".

    reference
    : *Optional* **string**
    : The label for the Invoice Reference (Invoice Number). Defaults to "Invoice reference".

    total_due
    : *Optional* **string**
    : The label for the total dollar amount due for the Invoice. Defaults to "Total amount due".

    summary
    : *Optional* **string**
    : The label for the section of the invoice summarizing the time worked by each employee, subtotals, expenses, and tax calculations for the invoice. Defaults to "Summary".

    work_time
    : *Optional* **string**
    : The label for the section of the summary that details the time worked by each employee. Defaults to "work time".

    no_tax
    : *Optional* **string**
    : The label for the section of the summary that outlines the dollar amounts in the invoice which do not have tax applied. Defaults to "no tax".

    tax
    : *Optional* **string**
    : The label for the section of the summary that details the taxes in the invoice. Defaults to "tax".

    subtotal
    : *Optional* **string**
    : The label for the subtotal dollar amount for the invoice. Defaults to "subtotal".

    total
    : *Optional* **string**
    : The label for the total dollar amount for the invoice. Defaults to "TOTAL".

    report
    : *Optional* **string**
    : The label for the report of total time worked for this invoice. Defaults to "Report".

    locale
    : *Optional* **string** of a locale code ([Supported locale codes](/locales_and_currencies/#locales))
    : The locale of the invoice, which is used to localize dates and other non-currency values. Defaults to "en-US".

    currency_name
    : *Optional* **string** of a currency name ([Supported Currency Names](/locales_and_currencies/#currency_names))
    : The name of the currency used in this invoice, which is used to correctly represent the currency value in the correct format. If no value is provided, then the currency will be automatically selected based on the `locale`.

    currency_symbol
    : *Optional* **string**
    : The custom currency symbol used in this invoice. If no value is provided, then the currency symbol will automatically be selected based on the `currency_name`.

    taxable_total
    : *Optional* **string**
    : The label for the total taxable dollar amount in the invoice. Defaults to "Total taxable".

    tax_total
    : *Optional* **string**
    : The label for the total dollar amount of taxes applied to the invoice. Defaults to "Total tax".

    taxfree_total
    : *Optional* **string**
    : The label for the total dollar amount of the invoice which is tax-free. Defaults to "Total taxfree".

    total_report
    : *Optional* **string**
    : The label for the total number of minutes worked, which is shown in the full report for this invoice. Defaults to "TOTAL".

    custom_css
    : *Optional* **string**
    : Any custom CSS used in the invoice.

    custom_html
    : *Optional* **string**
    : Any custom HTML used in the invoice.

    paypal_invoice
    : *Optional* **object**
    : This object is used to setup the invoice so that it can be paid via paypal. The fields are:

        paypal_address
        : *Required* **string**
        : The email address that will be receive the money for this invoice. **This should be *your* Paypal email address**.

        paypal_invoice_title
        : *Optional* **string**
        : The title for the paypal invoice. If no value is provided, then the `invoice_number` will be used.

        paypal_currency_code
        : *Optional* **string** of a [Paypal currency code](https://cms.paypal.com/mx/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes)
        : The paypal currency code used for this invoice. Defaults to "USD".


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
: *Optional* **string** in  ISO 8061 format `YYYY-MM-DD`
: the date the invoice was issued.

invoice_number
: *Optional* **string**
: Your identifier for the invoice. If no value is provided, then a value will be generated based on previous invoices

company_name
: *Optional* **string**
: the name of the company issuing the invoice.

company_details
: *Optional* **string**
: the mailing address and other information of the company issuing the invoice.

recipient
: *Optional* **string**
: the mailing address and other information invoice's recipient.

description
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices))
: a description of the invoice.

footer
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/invoicing/customizable-invoices)
: the footer for each page of the invoice.

show_hours
: *Optional* **boolean**
: `true` (**Default**): The hours worked will be shown when viewing the invoice
: `false`: The hours worked will not be shown when viewing the invoice.

show_details
: *Optional* **boolean**
: `true`: The details for this invoice will be shown when viewing the invoice.
: `false` (**Default**): The details for this invoice will not be shown when viewing the invoice.

show_summaries
: *Optional* **boolean**
: `true`: a summary of how many minutes each team member worked will be shown when viewing the invoice.
: `false` (**Default**): a summary of how many minutes each team member worked will not be shown when viewing the invoice.

customization
: *Optional* **object**
: The values in these fields are used a labels when viewing an invoice, modify how the invoice's values are displayed due to localization, or specify how the invoice is payable via Paypal. The fields are:

    title
    : *Optional* **string**
    : The title of the Invoice. Defaults to "Invoice".

    date
    : *Optional* **string**
    : The label for the Invoice Date. Defaults to "Date".

    project
    : *Optional* **string**
    : The label for the list of projects associated with this invoice. Defaults to "Projects".

    reference
    : *Optional* **string**
    : The label for the Invoice Reference (Invoice Number). Defaults to "Invoice reference".

    total_due
    : *Optional* **string**
    : The label for the total dollar amount due for the Invoice. Defaults to "Total amount due".

    summary
    : *Optional* **string**
    : The label for the section of the invoice summarizing the time worked by each employee, subtotals, expenses, and tax calculations for the invoice. Defaults to "Summary".

    work_time
    : *Optional* **string**
    : The label for the section of the summary that details the time worked by each employee. Defaults to "work time".

    no_tax
    : *Optional* **string**
    : The label for the section of the summary that outlines the dollar amounts in the invoice which do not have tax applied. Defaults to "no tax".

    tax
    : *Optional* **string**
    : The label for the section of the summary that details the taxes in the invoice. Defaults to "tax".

    subtotal
    : *Optional* **string**
    : The label for the subtotal dollar amount for the invoice. Defaults to "subtotal".

    total
    : *Optional* **string**
    : The label for the total dollar amount for the invoice. Defaults to "TOTAL".

    report
    : *Optional* **string**
    : The label for the report of total time worked for this invoice. Defaults to "Report".

    locale
    : *Optional* **string** of a locale code ([Supported locale codes](/locales_and_currencies/#locales))
    : The locale of the invoice, which is used to localize dates and other non-currency values. Defaults to "en-US".

    currency_name
    : *Optional* **string** of a currency name ([Supported Currency Names](/locales_and_currencies/#currency_names))
    : The name of the currency used in this invoice, which is used to correctly represent the currency value in the correct format. If no value is provided, then the currency will be automatically selected based on the `locale`.

    currency_symbol
    : *Optional* **string**
    : The custom currency symbol used in this invoice. If no value is provided, then the currency symbol will automatically be selected based on the `currency_name`.

    taxable_total
    : *Optional* **string**
    : The label for the total taxable dollar amount in the invoice. Defaults to "Total taxable".

    tax_total
    : *Optional* **string**
    : The label for the total dollar amount of taxes applied to the invoice. Defaults to "Total tax".

    taxfree_total
    : *Optional* **string**
    : The label for the total dollar amount of the invoice which is tax-free. Defaults to "Total taxfree".

    total_report
    : *Optional* **string**
    : The label for the total number of minutes worked, which is shown in the full report for this invoice. Defaults to "TOTAL".

    custom_css
    : *Optional* **string**
    : Any custom CSS used in the invoice.

    custom_html
    : *Optional* **string**
    : Any custom HTML used in the invoice.

    paypal_invoice
    : *Optional* **object**
    : This object is used to setup the invoice so that it can be paid via paypal. The fields are:

        paypal_address
        : *Required* **string**
        : The email address that will be receive the money for this invoice. **This should be *your* Paypal email address**.

        paypal_invoice_title
        : *Optional* **string**
        : The title for the paypal invoice. If no value is provided, then the `invoice_number` will be used.

        paypal_currency_code
        : *Optional* **string** of a [Paypal currency code](https://cms.paypal.com/mx/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes)
        : The paypal currency code used for this invoice. Defaults to "USD".

<%= json :invoice_edit_fields %>

### Response

<%= headers 200 %>
<%= json :invoice %>

## Get the entries included in an invoice

~~~
GET /imports/:id/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/entries" %>
<%= json :entry %>

## Add Entries to an Invoice

Add specific entries to the invoice, which will be included with the entries already added to this invoice. Note that if the entry's project is not currently one of the project's included in this Invoice, it will be automatically added.

~~~
POST /imports/:id/entries/
~~~

### Inputs

entries
: *Required* **array of integers**
: the IDs of the entries to be added to this invoice.

### Response

<%= headers 200 %>
<%= json :entry %>

## Remove Entries from an Invoice

Remove specific entries from this invoice. Any entries that are not included in this invoice will be ignored. Note that if the invoice does not contain any other entries or expenses associated with an entry's project, the project will automatically be removed from the Invoice.

~~~
PUT /imports/:id/entries/
~~~

### Inputs

entries
: *Required* **array of integers**
: the IDs of the entries to be removed from this invoice.

### Response

<%= headers 204 %>

## Remove all Entries from an Invoice

Removes all entries from this invoice. Note that if the invoice does not contain any other entries or expenses associated with an entry's project, the project will automatically be removed from the Invoice.

~~~
DELETE /imports/:id/entries/
~~~

### Response

<%= headers 204 %>

## Get the expenses included in an invoice

~~~
GET /imports/:id/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results.

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/expenses" %>
<%= json :expense %>

## Add Expenses to an Invoice

Add specific expenses to the invoice, which will be included with the expenses already added to this invoice. Note that if the expense's project is not currently one of the project's included in this Invoice, it will be automatically added.

~~~
POST /imports/:id/expenses/
~~~

### Inputs

expenses
: *Required* **array of integers**
: the IDs of the expenses to be added to this invoice.

### Response

<%= headers 200 %>
<%= json :expense %>

## Remove Expenses from an Invoice

Remove specific expenses from this invoice. Any expenses that are not included in this invoice will be ignored. Note that if the invoice does not contain any other entries or expenses associated with an entry's project, the project will automatically be removed from the Invoice.

~~~
PUT /imports/:id/expenses/
~~~

### Inputs

expenses
: *Required* **array of integers**
: the IDs of the expenses to be removed from this invoice.

### Response

<%= headers 204 %>

## Remove all Expenses from an Invoice

Removes all expenses from this invoice. Note that if the invoice does not contain any other entries or expenses associated with an entry's project, the project will automatically be removed from the Invoice.

~~~
DELETE /imports/:id/expenses/
~~~

### Response

<%= headers 204 %>

## Get the projects included in an invoice

~~~
GET /imports/:id/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "invoices/:id/projects" %>
<%= json :project %>

## Add Projects to an Invoice

When you add a project to the invoice, the project's entries and expenses will be automatically included based on the details of the `entries_and_expenses_selection` object. If `entries_and_expenses_selection` is not defined, then all uninvoiced entries and expenses from the projects will be automatically included.

~~~
POST /imports/:id/projects/
~~~

### Inputs

projects
: *Required* **array of integers**
: the IDs of projects to be added in this invoice.

entries_and_expenses_selection
: *Optional* **object**
: The details of how to automatically select entries and expenses from the projects included in this invoice. The fields are:

    selection_rules
    : *Optional* **string**
    : the selection pattern used. Accepted values are:
        * `all_uninvoiced` (**Default**): All uninvoiced entries and expenses will be included.
        * `date_range`: Only entries and expenses in this specific date range will be returned.
        * `none`: Do not search for any uninvoiced entries and expenses.

    from
    : *Required if entries_and_expenses_selection equals `date_range`* **string** in the ISO 8061 date format `YYYY-MM-DD`
    : Entries and Expenses from this date forward will be included in this invoice.

    to
    : *Required if entries_and_expenses_selection equals `date_range`* **string** in the ISO 8061 date format `YYYY-MM-DD`
    : Entries and Expenses on or before this date will be included in this invoice.

    include expenses
    : *Optional* **boolean**
    : `true` (*Default*): Uninvoiced expenses found using this selection rule are included in the invoice.
    : `false`: Uninvoiced expenses found using this selection rule are not included in the invoice.

## Remove Projects from an Invoice

Remove the projects

Remove specific projects from this Invoice. Any projects that are not included in this invoice will be ignored. Note that the entries or expenses associated with a project will automatically be removed from the Invoice.

When you remove a project from the invoice, it removes the project's entries and expenses from this invoice.

~~~
PUT /imports/:id/projects/
~~~

### Inputs

projects
: *Required* **array of integers**
: the IDs of projects to be aaded in this invoice.

### Response

<%= headers 204 %>

## Remove all Projects from an Invoice

Remove all projects from this Invoice. Note that the entries or expenses associated with this Invoice will automatically be removed from the Invoice.

~~~
DELETE /imports/:id/projects/
~~~

### Response

<%= headers 204 %>

## Recalculate the total dollar amount for the time worked in this invoice

Updates how the invoice calculates the total dollar amount corresponding to the entries included this invoice.

~~~
PUT /invoices/:id/hours_calculation
~~~

### Input

calculation_method
: *Required* **string**
: indicates what method will be used to calculate the total dollar amount for hours worked. Accepted values are:

    * `simple_hourly_rate`: a single hourly rate is used for across the entire invoice.
    * `custom_hourly_rates`: custom hourly rates can be defined for individual users via the `custom_hourly_rates` array. If no `custom_hourly_rate` is defined for an individual user, then the `simple_hourly_rate` is used for that user.
    * `flat_rate`: a flat rate is used for the the total cost of the hours in the invoice.

simple_hourly_rate
: *Required if `calculation_method` equals `simple_hourly_rate` or `custom_hourly_rate`* **decimal**
: the hourly rate used in this invoice.

custom_hourly_rates
: *Required if `calculation_method` equals `custom_hourly_rate`* **array of objects**
: the custom hourly rates for users, which are used to calculate the total dollar amount for the hours they worked in this invoice. The fields are:

    user
    : *Required* **integer**
    : the ID of the user

    hourly_rate
    : *Required* **decimal**
    : the hourly rate for this specific user.

flat_rate
: *Required if payment_type equals `flat_rate`* **decimal**
: The flat rate used as the total dollar amount for hours worked.

### Response

<%= headers 204 %>

## Add Custom Hourly Rates

Add custom hourly rates for specific users. This custom hourly rate will be used to calculate the total dollar amount for a user's entries. If a custom hourly rate is already defined for a user, then it is overwritten with the new hourly rate. Note that when a custom hourly rate is added, it changes the method used to calculate the total dollar amount for time worked to `custom_hourly_rates`

~~~
POST /imports/:id/custom_hourly_rates
~~~

### Inputs

custom_hourly_rates
    : *Required* **array of objects**
    : the custom hourly rates for users, which are used to calculate the total dollar amount for the hours they worked in this invoice. The fields are:

        user
        : *Required* **integer**
        : the ID of the user

        hourly_rate
        : *Required* **decimal**
        : the hourly rate for this specific user.

simple_hourly_rate
    : *Required* **decimal**
    : the numerical value of the hourly rate used if a user does not have a custom hourly rate.

### Response

<%= headers 204 %>

## Remove Custom Hourly Rates

Removes custom hourly rates for specific users. When a custom hourly rate is removed for a user, the total dollar amount for the hours they worked for this invoice is calculated using the `simple_hourly_rate`. Users who do not have a custom hourly rate will be ignored. Note that if there are no more remaining custom hourly rates, then the invoice will revert to using the `simple_hourly_rate` method of calculating the total dollar amount for time worked.

~~~
PUT /imports/:id/custom_hourly_rates
~~~

### Inputs

custom_hourly_rates
: *Required* **array of integers**
: the IDs of each user who's custom hourly rate will be removed.

### Response

<%= headers 204 %>

## Remove all Custom Hourly Rates

Remove all custom hourly rates from an invoice. Note that the Invoice will revert to using the `simple_hourly_rate` method of calculating the total dollar amount for time worked.

~~~
DELETE /imports/:id/custom_hourly_rates
~~~

### Response

<%= headers 204 %>

## Add Taxes to an Invoice

Add additional taxes to the invoice.

~~~
POST /imports/:id/taxes/
~~~

### Inputs

taxes
: *Required* **array of objects**
: the taxes to be added to this invoice. The fields are:

    percentage
    : *Required* **decimal** in percentage format (`00.00`)
    : the numeric percentage of the tax

    name
    : *Optional* **string**
    : the name of the tax


## Remove Taxes from an Invoice

Remove the specified taxes from an invoice. Any taxes that are not a part of this invoice will be ignored.

~~~
PUT /imports/:id/taxes/
~~~

### Inputs

taxes
: *Required* **array of integers**
: the IDs of taxes to be removed from this invoice.

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

When an invoice is deleted, all of the entries and expenses associated with it are marked as uninvoiced. An invoice cannot be deleted if it has been paid or one of the invoice's project has been archived. In this case, the response will include detailed information about why the entry couldn't be deleted.

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **paid**: the Invoice has been paid
* **archived_project**: the Invoice includes an archived Project