
customization
: *Optional* **object**
: These fields define the labels and localization settings used when viewing an invoice, and the details for making an invoice payable via Paypal. The fields are:

    title
    : *Optional* **string**
    : The title of the Invoice.
    : Defaults to the value used in a previous invoice for these projects, or "Invoice" if none is found.

    date
    : *Optional* **string**
    : The label for the Invoice Date.
	: Defaults to the value used in a previous invoice for these projects, or "Date" if none is found.

    project
    : *Optional* **string**
    : The label for the name of the projects involved in this invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Projects" if none is found.

    reference
    : *Optional* **string**
    : The label for the invoice's reference identifier (Invoice Number).
    : Defaults to the value used in a previous invoice for these projects, or "Invoice reference" if none is found.

    total_due
    : *Optional* **string**
    : The label for the total amount due for the Invoice.
    : Defaults to the value used in a previous invoice for these projects, or "Total amount due" if none is found.

    summary
    : *Optional* **string**
    : The label for the section of the invoice summarizing the time worked by each employee, subtotals, expenses, and tax calculations for the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Summary" if none is found.

    project_summary
    : *Optional* **string**
    : The label for the project summary section of the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Project summary" if none is found.

    user_summary
    : *Optional* **string**
    : The label for the user summary section of the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "People summary" if none is found.

    no_project_name
    : *Optional* **string**
    : the label used to summarize entries without any project in the project summary section.
	: Defaults to the value used in a previous invoice for these projects, or "No project" if none is found.

    work_time
    : *Optional* **string**
    : The label for the section of the summary that details the time worked by each employee.
	: Defaults to the value used in a previous invoice for these projects, or "work time" if none is found.

    no_tax
    : *Optional* **string**
    : The label for the section of the summary that outlines the amounts in the invoice which do not have tax applied.
	: Defaults to the value used in a previous invoice for these projects, or "no tax" if none is found.

    work_total
    : *Optional* **string**
    : The label used for the summary of the total amount of time worked in the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Total worked" if none is found.

    total
    : *Optional* **string**
    : The label for the total amount for the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "TOTAL" if none is found.

    report
    : *Optional* **string**
    : The label for the report of total time worked for this invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Report" if none is found.

    locale
    : *Optional* **string** of a locale code ([Supported locale codes](/invoice_locales/#locales))
    : The locale of the invoice, which is used to localize dates and other non-currency values.
    : Defaults to the value used in a previous invoice for these projects, or "en-US" if none is found.

    currency_code
    : *Optional* **string** of a [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) currency code ([Supported Currency Codes](/invoice_locales/#currency_names))
    : The [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) code of the currency used in this invoice, which is used to correctly represent the currency value in the correct format.
    : Defaults to the value used in a previous invoice for these projects.
    : If no previous invoice is found, the currency code will be automatically selected based on the `locale`.

    currency_symbol
    : *Optional* **string**
    : The custom currency symbol used in this invoice.
    : Defaults to the value used in a previous invoice for these projects.
    : If no previous invoice is found, the currency symbol will automatically be selected based on the `locale`.

    taxable_total
    : *Optional* **string**
    : The label for the total taxable amount in the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Total taxable" if none is found.

    tax_total
    : *Optional* **string**
    : The label for the total amount of taxes applied to the invoice.
	: Defaults to the value used in a previous invoice for these projects, or "Total tax" if none is found.

    taxfree_total
    : *Optional* **string**
    : The label for the total amount of the invoice which is tax-free.
	: Defaults to the value used in a previous invoice for these projects, or "Total taxfree" if none is found.

    total_report
    : *Optional* **string**
    : The label for the total number of minutes worked, which is shown in the full report for this invoice.
	: Defaults to the value used in a previous invoice for these projects, or "TOTAL" if none is found.

    custom_html
    : *Optional* **string**
    : Any custom HTML used in the invoice.
    : Defaults to the value used in a previous invoice for these projects.
    : If no previous invoice is found, the field will be blank.

    paypal_invoice
    : *Optional* **object**
    : This object is used to setup the invoice so that it can be paid via paypal. The fields are:

        paypal_address
        : *Optional* **string**
        : The email address that will be receive the money for this invoice. **This should be *your* Paypal email address**.
        : Defaults to the value used in a previous invoice for these projects.
        : If no previous invoice is found, the field will be blank.

        paypal_invoice_title
        : *Optional* **string**
        : The title for the paypal invoice. If no value is provided, then the `invoice_number` will be used.

        paypal_currency_code
        : *Optional* **string** of a [Paypal currency code](https://cms.paypal.com/mx/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes)
        : The paypal currency code used for this invoice.
	    : Defaults to the value used in a previous invoice for these projects, or "USD" if none is found.


    stripe_connect_payment
    : *Optional* **object**
    : This object is used to setup the invoice so that it can be paid via Stripe Connect. The fields are:

        payment_description
        : *Optional* **string**
        : The description for the payment in Stripe. If no value is provided, then the `invoice_number` will be used.

        currency_code
        : *Optional* **string** of a [Stripe currency code](https://stripe.com/docs/currencies)
        : The ISO currency code used for this invoice.
        : Defaults to the value used in a previous invoice for these projects, or "usd" if none is found.