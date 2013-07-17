---
layout: default
title: Invoice
---

# Invoice API

## Invoice Object Specification

	{
    "invoice": {
		//basic invoice information

		"id": 26642,
        //the current state of the invoice
		"state": "awaiting_payment",
        //the displayed number for the invoice
		"invoice_number": "",
        //the generated name for the invoice
		"name": "Knockd, Freckle Support",
        //whether the invoice is currently locked due to a pending paypal payment attempt
		"locked": false,

		//invoice display information
		"from": "2013-07-01T04:00:00Z",
		"to": "2013-07-31T04:00:00Z",
        "company_name": "Thomas Cannon",
        "company_details": "4 Boxthorne Court\\r\\nGreenville, SC 29615",
        "recipient_details": "",
		"description": "",
		"invoice_date": "2013-07-09",
		"footer": "",
		"show_hours": true,
		"show_details": false,
		"show_summaries": false,

        //the customizations for the invoice
        "customization": {
            "title": "Invoice",
            "date": "Date",
            "project": "Projects",
            "reference": "Invoice reference",
            "total_due": "Total amount due",
            "summary": "Summary",
            "work_time": "work time",
            "no_tax": "no tax",
            "tax": "tax",
            "subtotal": "subtotal",
            "total": "TOTAL",
            "report": "Report",
            "locale": "en-US",
            "currency_name": "",
            "currency_symbol": "$",
            "taxable_total": "Total taxable",
            "tax_total": "Total tax",
            "taxfree_total": "Total taxfree",
            "total_report": "TOTAL",
            "custom_css": null,
            "custom_html": "",
            "allow_paypal_invoice": true,
            "paypal_invoice_title": "",
            "paypal_currency_code": "USD",
            "paypal_address": "payment@test.com",

            "created_at": "2013-04-24T17:39:51Z",
            "updated_at": "2013-04-24T17:39:51Z",
        },

		//calculation fields

        //a boolean used to determine if unpaid expenses are included in the invoice
		"include_expenses": true,

        //indicates the payment type for the invoice (whether hourly or flat-rate)
        "payment_type": null,

        //the numerical hourly rate used for the entire invoice
        "hourly_rate": null,

        //the hourly rate used for the entire invoice, formatted in the invoice's currency
        "hourly_rate_with_currency": null,

        //the numerical flat rate used as the total work cost for the invoice
        "flat_rate": null,

		"custom_hourly_rates": [
            {
                "id": 446655,
                "user" : {
                    "id": : 5538,
                    "first_name": "John",
                    "last_name": "Test",
                    "avatar":{
                        "id": 5538,
                        "thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
                        "avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
                    },
                    "url": "http://apitest.letsfreckle.com/api/users/5538",
                },
                "rate": 30.50,
            }
        ]

        "taxes": [
            {
                "id": 88292,
                //the name of the tax
                "name":"Sales Tax",
                //the numeric value of the percentage of the tax
                "value": 15.00,
            }
        ]

        //the amount of the invoice which is taxable
		"amount_taxable": 100,
        //the amount of the invoice which is tax-free
		"amount_taxfree": 0,
        //the total amount of tax owed
		"amount_tax_total": 0,

        //the numerical invoice total
		"amount_total": 1,
        //the invoice total prepended formatted in the invoice's currency
		"amount_total_with_currency": "$1.00",

		// payment information
        //the token used when paying an invoice via paypal
		"token": "bqrnbojlbxqswtq9xla9uc40z",
        //the paypal payment details for this invoice
		"payment": null,

        //a read-only breakdown of payment activity for this invoice
        "payment_transactions":[
            {
                "description": "Notified that payment has been completed",
                "state" : "paid",
                "payment_method" : "paypal",
                "reference": "AP-AAAAABBBCCCCDDD111",
                "created_at": "2013-07-09T23:04:05Z",
                "updated_at": "2013-07-09T23:04:06Z",
            }
        ],

        "projects": [
            {
                "id": 37396,
                "name":"Gear GmbH",
                "stepping": 10,
                "enabled":  true,
                "billable": true,
                "color_hex": "ff9898",
                "url": "http://apitest.letsfreckle.com/api/projects/37396",
            }
        ],

        //a count of all the entries in the invoice
        "entries":0
        //the url to view all of the entries for this invoice
        "entries_url": "http://apitest.letsfreckle.com/invoices/26642/entries"

        //a count of all the expenses in the invoice
        "expenses": 0,
        //the url to view all of the expenses for this invoice
        "expenses_url": "http://apitest.letsfreckle.com/invoices/26642/expenses"

        "created_at": "2013-07-09T23:04:05Z",
        "updated_at": "2013-07-09T23:04:06Z",

        //deprecated fields?
        "from_address": null,
        "to_address": null,
        "tax_in_percent": null,
        "tax": null,
        "total": null,
        "subtotal": null,
    }
}

## Add Entry to Invoice
## Remove Entry from Invoice
## Replaces Entries in Invoice
## Add Expense to Invoice
## Remove Expense from Invoice
## Replace Expenses in Invoice
## Add Project to Invoice
## Remove Project from Invoice
## Replace projects In Invooce
## Add Custom Hourly Rates
## Remove Custom Hourly Rates
## Replace Custom Hourly Rates
## Add Taxes
## Remove Taxes
## Replace Taxes