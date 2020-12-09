module Noko
  module Resources
    OAUTH2_URL = "https://secure.nokotime.com"
    BASE_DOMAIN = "api.nokotime.com"
    API_V2_DOMAIN = BASE_DOMAIN + "/v2"
    BASE_URL   = "https://" + BASE_DOMAIN
    API_V2_URL = "https://" + API_V2_DOMAIN
    API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN = "scbp72wdc528hm8n52fowkma321tn58-jc1l2dkil0pnb75xjni48ad2wwsgr1d"

    VALIDATION_ERROR_EXAMPLE = {
       "message" => "Validation Failed",
       "errors" => [
        {
          "resource" => "Entry",
          "field" => "title",
          "code" => "missing_field"
        }
      ]
    }

    DELETE_ERROR_EXAMPLE = {
      "message" => "The Project cannot be deleted because it has entries, expenses, or invoices.",
      "errors" => [
        {
          "resource" => "Project",
          "field" => "base",
          "code" => "not_deletable"
        }
      ]
    }

    ARCHIVE_ERROR_EXAMPLE = {
      "message" => "The Project should be deleted because it does not have any entries, expenses, or invoices.",
      "errors" => [
        {
          "resource" => "Project",
          "field" => "base",
          "code" => "deletable"
        }
      ]
    }

    INVOICE_ENTRIES_AND_EXPENSES_ERROR_EXAMPLE = {
      "message" => "Entries or Expenses could not be added",
      "errors" => [
        {
          :resource => "Entry",
          :field => "entry_ids[1]",
          :code => "archived_project"
        },
        {
          :resource => "Expense",
          :field => "expense_ids[4]",
          :code => "missing"
        },
      ]
    }

    INVOICE_ENTRIES_ERROR_EXAMPLE = {
      "message" => "Entries could not be added",
      "errors" => [
        {
          :resource => "Entry",
          :field => "entry_ids[1]",
          :code => "archived_project"
        }
      ]
    }

    INVOICE_EXPENSES_ERROR_EXAMPLE = {
      "message" => "Expenses could not be added",
      "errors" => [
        {
          :resource => "Expense",
          :field => "expense_ids[4]",
          :code => "missing"
        }
      ]
    }

    OAUTH_AUTHORIZATION_TOKEN = {
      "id" => 1,
      "url" => "#{API_V2_URL}/authorizations/1",
      "scopes" => ["current_user","project"],
      "token" => "abc123",
      "app" => {
        "url" => "http://dabestnokoapp.com",
        "name" => "Da Best Noko App",
        "client_id" => "98643ycvfjfswx"
      },
      "note" => "describes what the token is generated for",
      "note_url" => "http://explanation.com/",
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z"

    }

    SIMPLE_USER = {
      "id" =>  5538,
      "email" =>  "john.test@test.com",
      "first_name" =>  "John",
      "last_name" =>  "Test",
      "profile_image_url" => "#{BASE_URL}/images/avatars/0000/0001/avatar.jpg",
      "url" =>  "#{API_V2_URL}/users/5538",
    }

    SIMPLE_TEAM = {
      "id" => 9283,
      "name" => "R&D",
      "url" => "#{API_V2_URL}/teams/9283"
    }

    USER = SIMPLE_USER.merge({
      "state" =>"active",
      "role" => "leader",

      "teams" => [SIMPLE_TEAM],

      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/users/5538/entries",

      "expenses" => 0,
      "expenses_url" => "#{API_V2_URL}/users/5538/expenses",

      "give_access_to_project_url" => "#{API_V2_URL}/users/5538/give_access_to_projects",
      "revoke_access_to_project_url" => "#{API_V2_URL}/users/5538/revoke_access_to_projects",
      "revoke_access_to_all_projects_url" => "#{API_V2_URL}/users/5538/revoke_access_to_all_projects",

      "activate_url" => "#{API_V2_URL}/users/5538/activate",
      "deactivate_url" => "#{API_V2_URL}/users/5538/deactivate",

      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    })

    CURRENT_USER = SIMPLE_USER.merge({
      "state" =>"active",
      "role" => "leader",

      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/users/5538/entries",

      "expenses" => 0,
      "expenses_url" => "#{API_V2_URL}/users/5538/expenses",

      "time_format" => "fraction",
      "week_start"=> "Sunday",
      "utc_offset" => -28800,
      "send_personal_weekly_report_email" => true,
      "send_team_weekly_report_email" => true,

      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    })

    USER_EDITABLE_FIELDS = {
      "email" => USER["email"],
      "first_name" => USER["first_name"],
      "last_name" => USER["last_name"],
      "role" => USER["role"]
    }

    TEAM = {
      "id" => 9283,
      "name" => "R&D",
      "users" => [SIMPLE_USER],
      "url" => "#{API_V2_URL}/teams/9283",
      "entries_url" => "#{API_V2_URL}/teams/9283/entries/",
      "users_url" => "#{API_V2_URL}/teams/9283/users/",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",

      "add_users_url" => "#{API_V2_URL}/teams/9283/add_users",
      "remove_users_url" => "#{API_V2_URL}/teams/9283/remove_users",
      "remove_all_users_url" => "#{API_V2_URL}/teams/9283/remove_all_users",
    }


    TEAM_CREATE_FIELDS = {
      "name" => TEAM["name"],
      "users" => [1,2,3],
    }

    TEAM_EDIT_FIELDS = {
      "name" => TEAM["name"]
    }

    ACCOUNT = {
      "id" =>  3344,
      "name" =>  "testit",
      "invoicing_enabled"=>  true,
      "owner" =>  SIMPLE_USER,

      "url" =>  "#{API_V2_URL}/account/",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    }

    SIMPLE_PROJECT = {
      "id" => 37396,
      "name" =>"Gear GmbH",
      "billing_increment" => 10,
      "enabled" =>  true,
      "billable" => true,
      "color" => "#ff9898",
      "url" => "#{API_V2_URL}/projects/37396",
    }

    SIMPLE_PROJECT_GROUP = {
      "id" => 3768,
      "name" => "Sprockets, Inc.",
      "url" => "#{API_V2_URL}/project_groups/3768"
    }

    PROJECT_GROUP = {
      "id" => 3768,
      "name" => "Sprockets, Inc.",
      "projects" => [SIMPLE_PROJECT],
      "url" => "#{API_V2_URL}/project_groups/3768",
      "entries_url" => "#{API_V2_URL}/project_groups/3768/entries/",
      "invoices_url" => "#{API_V2_URL}/project_groups/3768/invoices/",
      "projects_url" => "#{API_V2_URL}/project_groups/3768/projects/",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",

      "add_projects_url" => "#{API_V2_URL}/project_groups/3768/add_projects",
      "remove_projects_url" => "#{API_V2_URL}/project_groups/3768/remove_projects",
      "remove_all_projects_url" => "#{API_V2_URL}/project_groups/3768/remove_all_projects",
    }


    PROJECT_GROUP_CREATE_FIELDS = {
      "name" => PROJECT_GROUP["name"],
      "projects" => [1,2,3],
    }

    PROJECT_GROUP_EDIT_FIELDS = {
      "name" => PROJECT_GROUP["name"]
    }

    SIMPLE_IMPORT = {
      "id" => 8910,
      "url" => "#{API_V2_URL}/imports/8910"
    }

    IMPORT = {
      "id" => 8910,
      "type" => "basecamp",
      "import_tags" => true,
      "autocreate_projects" => true,
      "user" => SIMPLE_USER,
      "fallback_user" => SIMPLE_USER,

      "status" => "completed",

      "report_url" => "#{API_V2_URL}/imports/8910/report",

      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/imports/8910/entries",

      "tags" => 0,
      "tags_url" => "#{API_V2_URL}/imports/8910/tags",

      "projects" => 0,
      "projects_url" => "#{API_V2_URL}/imports/8910/projects",


      "url" => "#{API_V2_URL}/imports/8910",
      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    }

    EMPTY_IMPORT_ERROR = {
     "message" => "Validation Failed",
     "errors" => [
        {
         "resource" => "Import",
         "field" => "file",
         "code" => "missing_field"
        }
      ]
    }

    CREATED_IMPORT_RESPONSE = {
      "id" => IMPORT["id"],
      "import_tags" => IMPORT["import_tags"],
      "autocreate_projects" => IMPORT["autocreate_projects"],
      "user" => IMPORT["user"],
      "fallback_user" => IMPORT["fallback_user"],
      "status" => "in_progress",

      "url" => IMPORT["url"],
      "created_at" => IMPORT["created_at"],
      "updated_at" => IMPORT["updated_at"],
    }

    IMPORT_STATUS = {
      "status" => "in_progress"
    }

    IMPORT_DETAILS = {
      "entries_with_unknown_users" => 0,
      "unknown_users" => ["bob", "sue", "mary"],
      "line_errors" => [
        {
          "line" => 2,
          "fields" => [
            "July 16, 2013",
            "1 hour",
            "bob"
          ],
          "error" => "undefined method `+' for nil:NilClass"
        }
      ],
      "unknown_projects" => ["project 1", "project 2"],
      "entries_discarded" => 223,
      "entries_imported" => 48
    }

    # PROJECT_GOAL = {
    #   "id" => 445566,
    #   "budgeted_minutes" => 500,
    #   "total_logged_minutes" => 300,
    #   "billable_logged_minutes" => 200,
    #   "unbillable_logged_minutes" => 100,
    #   "starts_on" => "2001-01-02",
    #   "ends_on" => "2001-01-03",
    #   # "recurring_goal" =>{
    #   #   "id" => 8899,
    #   #   "renews" =>"yearly",
    #   #   "budgeted_minutes" => 1000,
    #   #   "starts_on" => "2001-01-02",
    #   #   "ends_on" => "2001-01-03",
    #   #   "url" => "#{API_V2_URL}/recurring_goals/8899"
    #   # },
    #   "url" =>"#{API_V2_URL}/goals/445566"
    # }

    # PROJECT_GOAL_EDITABLE_FIELDS = {
    #   "budgeted_minutes" => PROJECT_GOAL["budgeted_minutes"],
    #   "starts_on" => PROJECT_GOAL["starts_on"],
    #   "ends_on" => PROJECT_GOAL["ends_on"],
    # }

    # PROJECT_RECURRING_GOAL = {
    #   "id" => 8899,
    #   "renews" =>"yearly",
    #   "budgeted_minutes" => 1000,
    #   "starts_on" => "2001-01-02",
    #   "ends_on" => "2001-01-03",

    #   "goals" => [PROJECT_GOAL],

    #   "url" => "#{API_V2_URL}/recurring_goals/8899"
    # }

    # PROJECT_GOAL_CREATE_FIELDS = {
    #   "budgeted_minutes" => PROJECT_GOAL["budgeted_minutes"],
    #   "starts_on" => PROJECT_GOAL["starts_on"],
    #   "ends_on" => PROJECT_GOAL["ends_on"],
    #   "renews" => "yearly"
    # }

    SIMPLE_INVOICE = {
      "id" => 12345678,
      "reference" => "AA001",
      "invoice_date" => "2013-07-09",
      "state" => "unpaid",
      "total_amount" => 189.33,
      "url" => "#{API_V2_URL}/invoices/12345678",
    }

    PROJECT_CREATE_FIELDS = {
      "name" => SIMPLE_PROJECT["name"],
      "project_group_id" => SIMPLE_PROJECT_GROUP["id"],
      "billing_increment" => SIMPLE_PROJECT["billing_increment"],
      "color" => SIMPLE_PROJECT["color"]
    }

    PROJECT = SIMPLE_PROJECT.merge({
      "group" => SIMPLE_PROJECT_GROUP,
      "minutes" => 180,
      "billable_minutes" => 120,
      "unbillable_minutes" => 60,
      "invoiced_minutes" => 120,
      "remaining_minutes" => 630,
      "budgeted_minutes" => 750,

      "import" => SIMPLE_IMPORT,
      "invoices" => [SIMPLE_INVOICE],
      "participants" => [SIMPLE_USER],
      # "recurring_goals" => [PROJECT_RECURRING_GOAL],

      "entries" => 0,
      "entries_url" =>"#{API_V2_URL}/projects/37396/entries",
      "expenses" => 0,
      "expenses_url" => "#{API_V2_URL}/projects/37396/expenses",
      "url" =>"#{API_V2_URL}/projects/37396",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",

      "merge_url" => "#{API_V2_URL}/projects/37396/merge",
      "archive_url" => "#{API_V2_URL}/projects/37396/archive",
      "unarchive_url" => "#{API_V2_URL}/projects/37396/unarchive",
    })

    SIMPLE_TAG = {
      "id" => 249397,
      "name" => "noko",
      "billable" => true,
      "formatted_name" => "#noko",
      "url" => "#{API_V2_URL}/tags/249397"
    }

    TAG = SIMPLE_TAG.merge({
      "import" => {
        "id" => 8910,
        "url" => "#{API_V2_URL}/imports/8910"
      },
      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/tags/55629/entries",


      "merge_url" => "#{API_V2_URL}/tags/55629/merge",
      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    })

    ENTRY = {
      "id" => 1,
      "date" => "2012-01-09",
      "user" => SIMPLE_USER,
      "billable" => true,
      "minutes" => 60,
      "description" => "noko",
      "project" => SIMPLE_PROJECT,
      "tags" => [SIMPLE_TAG],
      "source_url" => "http://someapp.com/special/url/",
      "invoiced_at" => "2012-01-10T08:33:29Z",
      "invoice" => SIMPLE_INVOICE,
      "import" => SIMPLE_IMPORT,
      "approved_at" => "2012-01-10T08:33:29Z",
      "approved_by" => SIMPLE_USER,
      "url" => "#{API_V2_URL}/entries/1711626",
      "invoiced_outside_of_noko_url" => "#{API_V2_URL}/entries/1711626/marked_as_invoiced",
      "approved_url" => "#{API_V2_URL}/entries/1711626/approved",
      "unapproved_url" => "#{API_V2_URL}/entries/1711626/unapproved",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    }

    ENTRY_EDITABLE_FIELDS = {
      "date" => ENTRY["date"],
      "user_id" => SIMPLE_USER["id"],
      "minutes" => ENTRY["minutes"],
      "description" => ENTRY["description"],
      "project_id" => SIMPLE_PROJECT["id"],
      "project_name" => SIMPLE_PROJECT["name"],
      "source_url" => ENTRY["source_url"],
    }

    EXPENSE = {
      "id" => 2233,
      "price" => 14.55,
      "description" => "new software",
      "taxable" => true,
      "date" => "2010-06-09",

      "project" => SIMPLE_PROJECT,
      "invoice" => SIMPLE_INVOICE,
      "user" => SIMPLE_USER,

      "url" => "#{API_V2_URL}/expense/2233",
      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    }

    EXPENSE_EDITABLE_FIELDS = {
      "date" => EXPENSE["date"],
      "user_id" => SIMPLE_USER["id"],
      "price" => EXPENSE["price"],
      "taxable" => EXPENSE["taxable"],
      "description" => EXPENSE["description"],
      "project_id" => SIMPLE_PROJECT["id"]
    }

    INVOICE_CUSTOMIZATION_EDITABLE_FIELDS = {
      "title" => "Invoice",
      "date" => "Date",
      "project" => "Project",
      "reference" => "Invoice reference",
      "total_due" => "Total amount due",
      "summary" => "Summary",
      "project_summary" => "Project summary",
      "user_summary" => "People summary",
      "no_project_name" => "No project",
      "work_time" => "work time",
      "no_tax" => "no tax",
      "work_total" => "Total worked",
      "total" => "TOTAL",
      "report" => "Report",
      "locale" => "en-US",
      "currency_code" => "USD",
      "currency_symbol" => "$",
      "taxable_total" => "Total taxable",
      "tax_total" => "Total tax",
      "taxfree_total" => "Total taxfree",
      "total_report" => "TOTAL",
      "custom_html" => "<h1>My Custom Invoice</h1>",
      "allow_paypal_invoice" => true,
      "paypal_invoice_title" => "Paypal Invoice Title",
      "paypal_currency_code" => "USD",
      "paypal_address" => "payment@test.com",
      "allow_stripe_connect_payment" => true,
      "stripe_connect_payment_description" => "Stripe Payment Description",
      "stripe_connect_currency_code" => "usd",
    }

    INVOICE_CUSTOMIZATION = INVOICE_CUSTOMIZATION_EDITABLE_FIELDS.merge({
      "currency_name" => "United States dollar",
      "created_at" => "2013-04-24T17:39:51Z",
      "updated_at" => "2013-04-24T17:39:51Z",
    })

    INVOICE_CUSTOM_HOURLY_RATE = {
      "user" => SIMPLE_USER,
      "rate" => 30.50,
      "hourly_rate_with_currency" => "$30.50"
    }

    RATE_CALCULATION = {
      "calculation_method" => "custom_hourly_rates",
      "custom_hourly_rates" => [INVOICE_CUSTOM_HOURLY_RATE]
    }

    INVOICE_RATE_CALCULATION_FIELDS = {
      "calculation_method" => "custom_hourly_rates",
      "standard_hourly_rate" => 30.75,
      "custom_hourly_rates" => [
        {
          "user" => SIMPLE_USER["id"],
          "hourly_rate" => 15.25,
        },
      ],
      :flat_rate => 11000.72
    }

    INVOICE_TAX = {
      "id" => 88292,
      #the name of the tax
      "name" =>"Sales Tax",
      #the numeric value of the percentage of the tax
      "percentage" => 15.00,
    }

    INVOICE_TAX_FIELDS = {
      #the name of the tax
      "name" =>"Sales Tax",
      #the numeric value of the percentage of the tax
      "percentage" => 15.00,
    }

    PAYMENT_TRANSACTION = {
      :created_at => "2013-07-09T23:04:06Z",
      :description => "Sent to Paypal",
      :payment_method => "paypal",
      :reference => "AP-AAAAABBBCCCCDDD111",
      :invoice_state => "in_progress"
    }

    INVOICE_PAYMENET_DETAILS = {
      :paid_at => "2013-07-09T23:04:06Z",
      :reference => "AP-AAABBBDDDEEEE22222",
      :payment_method => "paypal"
    }

    INVOICE = {
      #basic invoice information
      "id" => 26642,
      #the current state of the invoice
      "state" => "paid",
      #the displayed number for the invoice
      "reference" => "AB 0001",
      #the date of the invoice
      "invoice_date" => "2013-07-09",
      #the generated name for the invoice
      "project_name" => "Knockd, Noko Support",

      #invoice display information
      "company_name" => "John Test",
      "company_details" => "1 Main Street\nMainsville, MA 11122",
      "recipient_details" => "",
      "description" => "",
      "footer" => "",

      # Which parts of the invoice to show
      "show_hours_worked" => true,
      "show_full_report" => false,
      "show_user_summaries" => false,
      "show_project_summaries" => false,
      "show_project_name_for_expenses" => false,

       #the customizations for the invoice
      "customization" => INVOICE_CUSTOMIZATION,

      #calculation fields

      #indicates the payment type for the invoice (whether hourly or flat-rate)
      "rate_calculation" => INVOICE_RATE_CALCULATION_FIELDS,

      "taxes" => [INVOICE_TAX],

      # The numerical totals for the invoice

      #the amount of the invoice which is taxable
      "taxable_amount" => 100,
      #the amount of the invoice which is tax-free
      "taxfree_amount" => 0,
      #the total amount of tax owed
      "tax_total_amount" => 0,
      #the numerical invoice total
      "total_amount" => 1,

      # The totals for the invoice, formatted in the invoice's currency
      "taxable_amount_with_currency" => "$100.00",
      "taxfree_amount_with_currency" => "$0.00",
      "tax_total_amount_with_currency" => "$0.00",
      "total_amount_with_currency" => "$1.00",

      # payment information

      #the paypal payment details for this invoice
      "payment" => INVOICE_PAYMENET_DETAILS,

      #a read-only breakdown of payment activity for this invoice
      "payment_transactions" =>[PAYMENT_TRANSACTION],

      "projects" => [SIMPLE_PROJECT],

      #a count of all the entries in the invoice
      "entries" => 123,
      #the url to view all of the entries for this invoice
      "entries_url" => "#{API_V2_URL}/invoices/26642/entries",

      #a count of all the expenses in the invoice
      "expenses" => 324,
      #the url to view all of the expenses for this invoice
      "expenses_url" => "#{API_V2_URL}/invoices/26642/expenses",

      # the public share URL
      "share_url" => "https://apitest.nokotime.com/i/bqrnbojlbxqswtq9xla9uc40z",

      "created_at" => "2013-07-09T23:04:05Z",
      "updated_at" => "2013-07-09T23:04:06Z",
      "url" => "#{API_V2_URL}/invoices/26642"
    }

    INVOICE_EDITABLE_FIELDS = {
      "invoice_date" => INVOICE["invoice_date"],
      "reference" => INVOICE["reference"],
      "project_name" => INVOICE["project_name"],
      "company_name" => INVOICE["company_name"],
      "company_details" => INVOICE["company_details"],
      "recipient_details" => INVOICE["recipient_details"],
      "description" => INVOICE["description"],
      "footer" => INVOICE["footer"],
      "show_hours_worked" => INVOICE["show_hours_worked"],
      "show_full_report" => INVOICE["show_full_report"],
      "show_user_summaries" => INVOICE["show_user_summaries"],
      "show_project_summaries" => INVOICE["show_project_summaries"],
      "rate_calculation" => INVOICE_RATE_CALCULATION_FIELDS,
    }

    INVOICE_CREATE_FIELDS = INVOICE_EDITABLE_FIELDS.merge({
      "entry_ids" => [ENTRY["id"]],
      "expense_ids" => [EXPENSE["id"]],
      "taxes" => [INVOICE_TAX_FIELDS],
    })

    INVOICE_EDIT_FIELDS = INVOICE_EDITABLE_FIELDS

    TIMER = {
      "id" => 123456,
      "state" => "running",
      "seconds" => 180,
      "formatted_time" => "00:03:00",
      "date" => "2013-07-09",
      "description" => "noko work",
      "user" => SIMPLE_USER,
      "project" => SIMPLE_PROJECT,
      "url" => "#{API_V2_URL}/projects/37396/timer",
      "start_url" => "#{API_V2_URL}/projects/37396/timer/start",
      "pause_url" => "#{API_V2_URL}/projects/37396/timer/pause",
      "add_or_subtract_time_url" => "#{API_V2_URL}/projects/37396/timer/add_or_subtract_time",
      "log_url"   => "#{API_V2_URL}/projects/37396/timer/log"
    }

    TIMER_UPDATE_EXAMPLE = {
      "minutes": 1,
      "seconds": 30
    }

    SUBDOMAIN = {
      :name => ACCOUNT["name"],
      :avatar => USER["profile_image_url"]
    }

    OAUTH_ACCESS_TOKEN = {
      :access_token => "abcedfghijk1234567890",
      :refresh_token => "poiuytrew098765",
      :expires_in=>12345678,
      :scope => "",
      :token_type => "bearer"
    }

    OAUTH_ACCESS_TOKEN_ERROR_EXAMPLE = {
      :error => "invalid_grant",
      :error_description => "The provided access grant is invalid, expired, or revoked (e.g. invalid assertion, expired authorization token, bad end-user password credentials, or mismatching authorization code and redirection URI)."
    }

    WEBHOOK_ENTRY_EVENTS = [
      'entry.created',
      'entry.updated',
      'entry.deleted',
      'entry.updated.approved',
      'entry.updated.unapproved',
      'entry.updated.invoiced',
      'entry.updated.uninvoiced',
    ]

    WEBHOOK_TAG_EVENTS = [
      'tag.created',
      'tag.updated',
      'tag.deleted',
      'tag.deleted.merged',
    ]

    WEBHOOK_EXPENSE_EVENTS = [
      'expense.created',
      'expense.updated',
      'expense.deleted',
    ]

    WEBHOOK_INVOICE_EVENTS = [
      'invoice.created',
      'invoice.updated',
      'invoice.deleted',
      'invoice.updated.paid',
      'invoice.updated.unpaid',
    ]

    WEBHOOK_PROJECT_EVENTS = [
      'project.created',
      'project.updated',
      'project.updated.archived',
      'project.updated.unarchived',
      'project.deleted',
      'project.deleted.merged',
    ]

    WEBHOOK_PROJECT_GROUP_EVENTS = [
      'project_group.created',
      'project_group.updated',
      'project_group.deleted',
      'project_group.deleted.merged',
    ]


    WEBHOOK_TEAM_EVENTS = [
      'team.created',
      'team.updated',
      'team.deleted',
    ]

    WEBHOOK_USER_EVENTS =[
      'user.created',
      'user.updated',
      'user.updated.deactivated',
      'user.updated.activated',
      'user.deleted',
    ]

    EXAMPLE_WEBHOOK_PAYLOAD_URI = "http://dabestnokoapp.com/webhooks/entry_events"

    EXAMPLE_WEBHOOK_SUMMARY = {
      id: 123456,
      name: "Da Best Noko Webhook"
    }

    EXAMPLE_WEBHOOK_PAYLOAD_CHANGES = {
      "minutes" => [30, ENTRY["minutes"]],
      "invoiced_at" => [nil, ENTRY["invoiced_at"]],
      "invoice" => [nil, ENTRY["invoice"]],
    }

    WEBHOOK = EXAMPLE_WEBHOOK_SUMMARY.merge({
      state: "enabled",
      events: WEBHOOK_ENTRY_EVENTS,
      payload_uri: EXAMPLE_WEBHOOK_PAYLOAD_URI,
      url: "#{API_V2_URL}/webhooks/123456",
      add_events_url: "#{API_V2_URL}/webhooks/123456/add_events",
      remove_events_url: "#{API_V2_URL}/webhooks/123456/remove_events",
      reroll_secret_url: "#{API_V2_URL}/webhooks/123456/reroll_secret",
      enable_url: "#{API_V2_URL}/webhooks/123456/enable",
      disable_url: "#{API_V2_URL}/webhooks/123456/disable",
    })

    WEBHOOK_EDIT_FIELDS = {
      name: "Da Best Noko Webhook",
      payload_uri: EXAMPLE_WEBHOOK_PAYLOAD_URI,
    }

    WEBHOOK_EDIT_EVENTS_FIELDS = {
      events: WEBHOOK_ENTRY_EVENTS
    }

    WEBHOOK_CREATE_FIELDS = WEBHOOK_EDIT_FIELDS.merge(WEBHOOK_EDIT_EVENTS_FIELDS)

    WEBHOOK_SECRET_DATA = { secret: "abcd-1234-secret-value" }

    CREATED_WEBHOOK = WEBHOOK.merge(WEBHOOK_SECRET_DATA)

    EXAMPLE_WEBHOOK_PAYLOAD_HEADERS = {
      "Content-Type" => 'application/json',
      "X-Noko-EventCategory" => "entry",
      "X-Noko-Delivery" => "050db47d-20f3-4479-86c3-e7a237f670e5",
      "X-Noko-Signature" => "97edbb33123042fb0df0f78eef173123d50b095b769f419a601fbdf40918b8fe",
      "User-Agent" => "Noko-Webhooks"
    }

    EXAMPLE_WEBHOOK_PAYLOAD_BODY = {
      webhook: EXAMPLE_WEBHOOK_SUMMARY,
      type: "entry.updated",
      created_at: ENTRY["updated_at"],
      changes: EXAMPLE_WEBHOOK_PAYLOAD_CHANGES,
      object: ENTRY,
    }

    EXAMPLE_WEBHOOK_PING_HEADERS = {
      "Content-Type" => 'application/json',
      "X-Noko-EventCategory" => "webhook",
      "X-Noko-Delivery" => "6578e997-d144-46fb-a67d-07c886d1a7a1",
      "X-Noko-Signature" => "97edbb33123042fb0df0f78eef173123d50b095b769f419a601fbdf40918b8fe",
      "User-Agent" => "Noko-Webhooks"
    }

    EXAMPLE_WEBHOOK_PING_BODY = {
      "payload_id" => "6578e997-d144-46fb-a67d-07c886d1a7a1",
      "created_at" => "2020-07-29T15:19:28Z",
      "type" => "webhook.ping",
      "object"=> {},
      "webhook" => EXAMPLE_WEBHOOK_SUMMARY
    }

    BROADCAST_RECEIVER_SUBJECTS = ['timer']

    EXAMPLE_BROADCAST_RECEIVER_URI = "http://dabestnokoapp.com/broadcasts/timer_messages"

    EXAMPLE_BROADCAST_RECEIVER_SUMMARY = {
      id: 77885522,
      name: "Da Best Timer Sync"
    }

     BROADCAST_RECEIVER = EXAMPLE_BROADCAST_RECEIVER_SUMMARY.merge({
      state: "enabled",
      subjects: BROADCAST_RECEIVER_SUBJECTS,
      payload_uri: EXAMPLE_BROADCAST_RECEIVER_URI,
      url: "#{API_V2_URL}/broadcast_receivers/987654",
      add_subjects_url: "#{API_V2_URL}/broadcast_receivers/987654/add_subjects",
      remove_subjects_url: "#{API_V2_URL}/broadcast_receivers/987654/remove_subjects",
      reroll_secret_url: "#{API_V2_URL}/broadcast_receivers/987654/reroll_secret",
      enable_url: "#{API_V2_URL}/broadcast_receivers/987654/enable",
      disable_url: "#{API_V2_URL}/broadcast_receivers/987654/disable",
    })

    BROADCAST_RECEIVER_EDIT_FIELDS = {
      name: "Da Best Timer Sync",
      payload_uri: EXAMPLE_BROADCAST_RECEIVER_URI
    }

    BROADCAST_RECEIVER_EDIT_SUBJECTS_FIELDS = {
      subjects: BROADCAST_RECEIVER_SUBJECTS
    }

    BROADCAST_RECEIVER_CREATE_FIELDS = BROADCAST_RECEIVER_EDIT_FIELDS.merge(BROADCAST_RECEIVER_EDIT_SUBJECTS_FIELDS)

    BROADCAST_RECEIVER_SECRET_DATA = {secret: "gfds-64563-secret-value"}

    CREATED_BROADCAST_RECEIVER = BROADCAST_RECEIVER.merge(BROADCAST_RECEIVER_SECRET_DATA)

    EXAMPLE_BROADCAST_HEADERS = {
      "Content-Type" => 'application/json',
      "X-Noko-BroadcastSubject" => "timer",
      "X-Noko-Signature" => "97edbb33123042fb0df0f78eef173123d50b095b769f419a601fbdf40918b8fe",
      "User-Agent" => "Noko-Broadcasts"
    }

    EXAMPLE_BROADCAST_BODY = {
      "broadcast_receiver" => EXAMPLE_BROADCAST_RECEIVER_SUMMARY,
      "sent_at" => "2020-09-30T15:19:28Z",
      "last_event" => "timer.running",
      "subject" => {
        "type" => "timer",
        "url" => TIMER["url"]
      }
    }
  end
end

include Noko::Resources
