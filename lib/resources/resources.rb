module Freckle
  module Resources
    BASE_DOMAIN = "api.letsfreckle.com"
    API_V2_DOMAIN = BASE_DOMAIN + "/v2"
    BASE_URL   = "https://" + BASE_DOMAIN
    API_V2_URL = "https://" + API_V2_DOMAIN

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
      "message" => "Unable to be deleted",
      "errors" => [
        {
          "resource" => "Project",
          "field" => "entries",
          "code" => "dependent"
        }
      ]
    }

    ARCHIVE_ERROR_EXAMPLE = {
      "message" => "Should be deleted",
      "errors" => [
        {
          "resource" => "Project",
          "field" => "id",
          "code" => "deletable"
        }
      ]
    }

    OAUTH_AUTHORIZATION_TOKEN = {
      "id" => 1,
      "url" => "#{API_V2_URL}/authorizations/1",
      "scopes" => ["current_user","project"],
      "token" => "abc123",
      "app" => {
        "url" => "http://dabestfreckleapp.com",
        "name" => "Da Best Freckle App",
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
      "avatar" => {
        "thumbnail" =>  "#{BASE_URL}/images/avatars/0000/0001/avatar_profile.jpg",
        "avatar" =>  "#{BASE_URL}/images/avatars/0000/0001/avatar.jpg"
      },
      "url" =>  "#{API_V2_URL}/users/5538",
    }

    USER = {
      "id" => 5538,
      "email" => "john.test@test.com",
      "first_name" => "John",
      "last_name" => "Test",
      "avatar" =>{
        "thumbnail" => "#{BASE_URL}/images/avatars/0000/0001/avatar_profile.jpg",
        "avatar" => "#{BASE_URL}/images/avatars/0000/0001/avatar.jpg"
      },
      "state" =>"active",
      "role" => "member",

      "participating_projects" => 0,
      "participating_projects_url" => "#{API_V2_URL}/users/5538/participating_projects",

      "accessible_projects" => 0,
      "accessible_projects_url" => "#{API_V2_URL}/users/5538/accessible_projects",

      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/users/5538/entries",

      "expenses" => 0,
      "expenses_url" => "#{API_V2_URL}/users/5538/expenses",

      "add_project_access" => "#{API_V2_URL}/users/5538/project_access/add",
      "remove_project_access" => "#{API_V2_URL}/users/5538/project_access/remove",

      "url" => "#{API_V2_URL}/users/5538",
      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    }

    CURRENT_USER = USER.merge({
      "time_format" => "fraction",
      "week_start"=> "Sunday",
      "utc_offset" => -28800,
      "send_personal_weekly_report_email" => true,
      "send_team_weekly_report_email" => true,
    })

    USER_EDITABLE_FIELDS = {
      "email" => USER["email"],
      "first_name" => USER["first_name"],
      "last_name" => USER["last_name"],
      "role" => USER["role"]
    }

    ACCOUNT = {
      "id" =>  3344,
      "plan_name" =>  "Freelancer",
      "subdomain" =>  "testit",
      "address" =>  {
        "address1" =>  "1345 Main Street",
        "address2" =>  "Room 3",
        "city" =>  "Mainsville",
        "state" =>  "MA",
        "zip" =>  "12345",
        "country" =>  "USA",
        "phone" =>  "(111)-222-3333",
      },

      "ccinvoices"=>  "john.test@test.com",
      "invoicing_enabled"=>  true,
      "owner" =>  SIMPLE_USER,

      "url" =>  "#{API_V2_URL}/account/",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    }

    ACCOUNT_EDITABLE_FIELDS = {
      "address" => ACCOUNT["address"]
    }

    SIMPLE_PROJECT = {
      "id" => 37396,
      "name" =>"Gear GmbH",
      "stepping" => 10,
      "enabled" =>  true,
      "billable" => true,
      "color_hex" => "ff9898",
      "url" => "#{API_V2_URL}/projects/37396",
    }

    SIMPLE_PROJECT_GROUP = {
      "id" => 3768,
      "name" => "Sprockets, Inc.",
      "url" => "#{API_V2_URL}/groups/3768"
    }

    PROJECT_GROUP = {
      "id" => 3768,
      "name" => "Sprockets, Inc.",
      "projects" => [SIMPLE_PROJECT],
      "participants" => [SIMPLE_USER],
      "url" => "#{API_V2_URL}/groups/3768",
      "entries_url" => "#{API_V2_URL}/groups/3768/entries/",
      "invoices_url" => "#{API_V2_URL}/groups/3768/invoices/",
      "projects_url" => "#{API_V2_URL}/groups/3768/projects/",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    }


    PROJECT_GROUP_CREATE_FIELDS = {
      "name" => PROJECT_GROUP["name"],
      "projects" => [1,2,3],
    }

    PROJECT_GROUP_EDIT_FIELDS = {
      "name" => PROJECT_GROUP["name"]
    }

    VALIDATION_ERROR_PROJECT_ALREADY_ASSOCIATED_WITH_A_GROUP = {
      "message" => "Validation Failed",
      "errors" => [
        {
          "resource" => "Project Group",
          "field" => "projects",
          "code" => "already_exists"
        }
      ]
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

    PROJECT_GOAL = {
      "id" => 445566,
      "budgeted_minutes" => 500,
      "total_logged_minutes" => 300,
      "billable_logged_minutes" => 200,
      "unbillable_logged_minutes" => 100,
      "starts_on" => "2001-01-02",
      "ends_on" => "2001-01-03",
      "recurring_goal" =>{
        "id" => 8899,
        "renews" =>"yearly",
        "budgeted_minutes" => 1000,
        "starts_on" => "2001-01-02",
        "ends_on" => "2001-01-03",
        "url" => "#{API_V2_URL}/recurring_goals/8899"
      },
      "url" =>"#{API_V2_URL}/goals/445566"
    }

    PROJECT_GOAL_EDITABLE_FIELDS = {
      "budgeted_minutes" => PROJECT_GOAL["budgeted_minutes"],
      "starts_on" => PROJECT_GOAL["starts_on"],
      "ends_on" => PROJECT_GOAL["ends_on"],
    }

    PROJECT_RECURRING_GOAL = {
      "id" => 8899,
      "renews" =>"yearly",
      "budgeted_minutes" => 1000,
      "starts_on" => "2001-01-02",
      "ends_on" => "2001-01-03",

      "goals" => [PROJECT_GOAL],

      "url" => "#{API_V2_URL}/recurring_goals/8899"
    }

    PROJECT_GOAL_CREATE_FIELDS = {
      "budgeted_minutes" => PROJECT_GOAL["budgeted_minutes"],
      "starts_on" => PROJECT_GOAL["starts_on"],
      "ends_on" => PROJECT_GOAL["ends_on"],
      "renews" => "yearly"
    }

    SIMPLE_INVOICE = {
      "id" => 12345678,
      "invoice_number" => "AA001",
      "state" => "unpaid",
      "total" => 189.33,
      "url" => "#{API_V2_URL}/invoices/12345678",
    }

    PROJECT = SIMPLE_PROJECT.merge({
      "group" => SIMPLE_PROJECT_GROUP,
      "minutes" => 180,
      "billable_minutes" => 120,
      "unbillable_minutes" => 60,
      "invoiced_minutes" => 120,
      "remaining_minutes" => 630,
      "budget_minutes" => 750,

      "import" => IMPORT,
      "invoices" => [SIMPLE_INVOICE],
      "participants" => [SIMPLE_USER],
      "goals" => [PROJECT_GROUP],
      "recurring_goals" => [PROJECT_RECURRING_GOAL],

      "entries" => 0,
      "entries_url" =>"#{API_V2_URL}/projects/34580/entries",
      "expenses" => 0,
      "expenses_url" => "#{API_V2_URL}/projects/34580/expenses",
      "url" =>"#{API_V2_URL}/projects/34580",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    })

    SIMPLE_TAG = {
      "id" => 249397,
      "name" => "freckle",
      "billable" => true,
      "url" => "#{API_V2_URL}/tags/249397"
    }

    TAG = SIMPLE_TAG.merge({
      "import" => {
        "id" => 8910,
        "url" => "#{API_V2_URL}/imports/8910"
      },
      "entries" => 0,
      "entries_url" => "#{API_V2_URL}/tags/55629/entries",

      "created_at" => "2010-06-09T20:44:57Z",
      "updated_at" => "2010-06-09T20:44:57Z",
    })

    ENTRY = {
      "id" => 1,
      "date" => "2012-01-09",
      "user" => SIMPLE_USER,
      "billable" => true,
      "minutes" => 60,
      "description" => "freckle",
      "project" => SIMPLE_PROJECT,
      "tags" => [SIMPLE_TAG],
      "source_url" => "http://someapp.com/special/url/",
      "invoiced_at" => "2012-01-10T08:33:29Z",
      "invoice" => SIMPLE_INVOICE,
      "import" => SIMPLE_IMPORT,
      "url" => "#{API_V2_URL}/entries/1711626",
      "created_at" => "2012-01-09T08:33:29Z",
      "updated_at" => "2012-01-09T08:33:29Z",
    }

    ENTRY_EDITABLE_FIELDS = {
      "date" => ENTRY["date"],
      "user" => SIMPLE_USER["id"],
      "minutes" => ENTRY["minutes"],
      "description" => ENTRY["description"],
      "project" => SIMPLE_PROJECT["id"],
      "source_url" => ENTRY["source_url"],
    }

    EXPENSE = {
      "id" => 2233,
      "price" => 14.55,
      "description" => "new software",
      "apply_tax" => true,
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
      "user" => SIMPLE_USER["id"],
      "price" => EXPENSE["price"],
      "apply_tax" => EXPENSE["apply_tax"],
      "description" => EXPENSE["description"],
      "project" => SIMPLE_PROJECT["id"]
    }

    INVOICE_CUSTOMIZATION = {
      "title" => "Invoice",
      "date" => "Date",
      "project" => "Projects",
      "reference" => "Invoice reference",
      "total_due" => "Total amount due",
      "summary" => "Summary",
      "work_time" => "work time",
      "no_tax" => "no tax",
      "tax" => "tax",
      "subtotal" => "subtotal",
      "total" => "TOTAL",
      "report" => "Report",
      "locale" => "en-US",
      "currency_name" => "",
      "currency_symbol" => "$",
      "taxable_total" => "Total taxable",
      "tax_total" => "Total tax",
      "taxfree_total" => "Total taxfree",
      "total_report" => "TOTAL",
      "custom_css" => nil,
      "custom_html" => "",
      "allow_paypal_invoice" => true,
      "paypal_invoice_title" => "",
      "paypal_currency_code" => "USD",
      "paypal_address" => "payment@test.com",

      "created_at" => "2013-04-24T17:39:51Z",
      "updated_at" => "2013-04-24T17:39:51Z",
    }

    INVOICE_CUSTOM_HOURLY_RATE = {
      "user" => SIMPLE_USER,
      "rate" => 30.50,
      "hourly_rate_with_currency" => "$30.50"
    }

    HOURS_CALCULATION = {
      "calculation_method" => "custom_hourly_rates",
      "custom_hourly_rates" => [INVOICE_CUSTOM_HOURLY_RATE]
    }

    INVOICE_HOURS_CALCULATION_FIELDS = {
      #accepted values: default, simple_hourly_rate, custom_hourly_rates, flat_rate
      "calculation_method" => "custom_hourly_rates",
      # if simple_hourly_rate or custom_hourly_rate are selected: "simple_hourly_rate" => 30.75,
      "custom_hourly_rates" => [
        {
          "user" => SIMPLE_USER["id"],
          "hourly_rate" => 15.25,
        },
      ],
      # if flat_rate is selected: "flat_rate" => 11000.72,
      #a boolean used to determine if unpaid expenses are included in the invoice
      "include_expenses" => true,
    }

    INVOICE_ENTRY_AND_EXPENSES_SELECTION_FIELDS = {
      "selection_rules" => "all_uninvoiced",
      "from" => "2013-01-01",
      "to" => "2013-01-01"
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

    INVOICE = {
      #basic invoice information
      "id" => 26642,
      #the current state of the invoice
      "state" => "awaiting_payment",
      #the displayed number for the invoice
      "invoice_number" => "AB 0001",
      #the date the invoice was posted on
      "invoice_date" => "2013-07-09",
      #the generated name for the invoice
      "name" => "Knockd, Freckle Support",

      #invoice display information
      "company_name" => "John Test",
      "company_details" => "1 Main Street\\r\\nMainsville, MA 11122",
      "recipient_details" => "",
      "description" => "",
      "footer" => "",
      "show_hours" => true,
      "show_details" => false,
      "show_summaries" => false,

       #the customizations for the invoice
      "customization" => INVOICE_CUSTOMIZATION,

      #calculation fields

      #indicates the payment type for the invoice (whether hourly or flat-rate)
      "hours_calculation" => HOURS_CALCULATION,

      "taxes" => [INVOICE_TAX],
      #the amount of the invoice which is taxable
      "amount_taxable" => 100,
      #the amount of the invoice which is tax-free
      "amount_taxfree" => 0,
      #the total amount of tax owed
      "amount_tax_total" => 0,

      #the numerical invoice total
      "amount_total" => 1,
      #the invoice total prepended formatted in the invoice's currency
      "amount_total_with_currency" => "$1.00",

      # payment information

      "share_url" => "https://apitest.letsfreckle.com/i/bqrnbojlbxqswtq9xla9uc40z",

      #the paypal payment details for this invoice
      "payment" => nil,

      #a read-only breakdown of payment activity for this invoice
      "payment_transactions" =>[
          {
              "description" => "Notified that payment has been completed",
              "state" => "paid",
              "payment_method" => "paypal",
              "reference" => "AP-AAAAABBBCCCCDDD111",
              "created_at" => "2013-07-09T23:04:05Z",
              "updated_at" => "2013-07-09T23:04:06Z",
          }
      ],

      "projects" => [SIMPLE_PROJECT],

      #a count of all the entries in the invoice
      "entries" =>0,
      #the url to view all of the entries for this invoice
      "entries_url" => "#{API_V2_URL}/invoices/26642/entries",

      #a count of all the expenses in the invoice
      "expenses" => 0,
      #the url to view all of the expenses for this invoice
      "expenses_url" => "#{API_V2_URL}/invoices/26642/expenses",

      "created_at" => "2013-07-09T23:04:05Z",
      "updated_at" => "2013-07-09T23:04:06Z",

      #deprecated fields?
      "from_address" => nil,
      "to_address" => nil,
      "tax_in_percent" => nil,
      "tax" => nil,
      "total" => nil,
      "subtotal" => nil,
    }

    INVOICE_CREATE_FIELDS = {
      "date" => INVOICE["date"],
      "invoice_number" => INVOICE["invoice_number"],
      "company_name" => INVOICE["company_name"],
      "company_details" => INVOICE["company_details"],
      "recipient" => INVOICE["recipient"],
      "description" => INVOICE["description"],
      "footer" => INVOICE["footer"],
      "show_hours" => INVOICE["show_hours"],
      "show_details" => INVOICE["show_details"],
      "hours_calculation" => INVOICE_HOURS_CALCULATION_FIELDS,
      "entries_and_expenses_selection" => INVOICE_ENTRY_AND_EXPENSES_SELECTION_FIELDS,
      "projects" => [PROJECT["id"]],
      "entries" => [ENTRY["id"]],
      "expenses" => [EXPENSE["id"]],
      "include_expenses" => INVOICE["include_expenses"],
      "taxes" => [INVOICE_TAX_FIELDS],
      "customization" => INVOICE_CUSTOMIZATION
    }

    INVOICE_EDIT_FIELDS = {
      "date" => INVOICE["date"],
      "invoice_number" => INVOICE["invoice_number"],
      "company_name" => INVOICE["company_name"],
      "company_details" => INVOICE["company_details"],
      "recipient" => INVOICE["recipient"],
      "description" => INVOICE["description"],
      "footer" => INVOICE["footer"],
      "show_hours" => INVOICE["show_hours"],
      "show_details" => INVOICE["show_details"],
      "customization" => INVOICE_CUSTOMIZATION
    }

    TIMER = {
      "initial_start_time" => "2013-07-09T23:04:05Z",
      "last_start_time" => "2013-07-10T01:04:05Z",
      "state" => "running",
      "seconds" => 180,
      "entry_date" => "2013-07-09",
      "description" => "freckle work",
      "user" => SIMPLE_USER,
      "project" => SIMPLE_PROJECT,
      "url" => "#{API_V2_URL}/projects/34580/timer",
      "start_url" => "#{API_V2_URL}/projects/34580/timer/start",
      "pause_url" => "#{API_V2_URL}/projects/34580/timer/pause",
      "log_url"   => "#{API_V2_URL}/projects/34580/timer/log"
    }

    SUBDOMAIN = {
      :subdomain => ACCOUNT["subdomain"],
      :avatar => USER["avatar"]
    }
  end
end

include Freckle::Resources
