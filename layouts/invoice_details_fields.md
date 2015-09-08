
reference
: *Optional* **string**
: The invoice's reference identifier. If no value is provided, a value will be generated based on previous invoices.

project_name
: *Optional* **string**
: The name of the projects involved in this invoice.

company_name
: *Optional* **string**
: The name of the company issuing the invoice.

company_details
: *Optional* **string**
: The mailing address and other information for the company issuing the invoice.

recipient_details
: *Optional* **string**
: The mailing address and other information for the invoice's recipient.

description
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/article/84-customizing-invoice-labels-and-formatting)
: A description of the invoice.

footer
: *Optional* **string** that supports a [limited version of Markdown](http://help.letsfreckle.com/article/84-customizing-invoice-labels-and-formatting)
: The footer for each page of the invoice.

show_hours_worked
: *Optional* **boolean**
: `true` (**Default**): The hours worked will be shown when viewing the invoice
: `false`: The hours worked will not be shown when viewing the invoice.

show_full_report
: *Optional* **boolean**
: `true`: The full report will be shown when viewing the invoice.
: `false` (**Default**): The full report will not be shown when viewing the invoice.

show_user_summaries
: *Optional* **boolean**
: `true`: A summary of how many minutes each team member worked will be shown when viewing the invoice.
: `false` (**Default**): A summary of how many minutes each team member worked will not be shown when viewing the invoice.

show_project_summaries
: *Optional* **boolean**
: `true`: A summary of how many minutes were worked for each project will be shown when viewing the invoice.
: `false` (**Default**): A summary of how many minutes were worked for each project will not be shown when viewing the invoice.

show_project_name_for_expenses
: *Optional* **boolean**
: `true`: The expense's project name will be shown next to its description when viewing the invoice.
: `false` (**Default**): The expense's project name will not be shown next to its description when viewing the invoice