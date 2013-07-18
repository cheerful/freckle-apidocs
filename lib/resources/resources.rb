module Freckle
	module Resources
		SIMPLE_USER = {
			"id" =>  5538,
			"email" =>  "john.test@test.com",
			"first_name" =>  "John",
			"last_name" =>  "Test",
			"avatar" => {
				"id" =>  5538,
				"thumbnail" =>  "http=> //apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
				"avatar" =>  "http=> //apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
			},
			"url" =>  "http=> //apitest.letsfreckle.com/api/users/5538",
		}

		ACCOUNT = {
			"id" =>  3344,
			"plan_name" =>  "Freelancer",
			"subdomain" =>  "testit",
			"title" =>  "Test It!",
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

			"url" =>  "http://apitest.letsfreckle.com/api/account/",
			"created_at" => "2012-01-09T08:33:29Z",
		  "updated_at" => "2012-01-09T08:33:29Z",
		}

		ACCOUNT_EDITABLE_FIELDS = {
			"title" => ACCOUNT["title"],
			"address" => ACCOUNT["address"]
		}

		SIMPLE_PROJECT = {
	  	"id" => 37396,
	  	"name" =>"Gear GmbH",
	  	"stepping" => 10,
	  	"enabled" =>  true,
	  	"billable" => true,
	  	"color_hex" => "ff9898",
	  	"url" => "http://apitest.letsfreckle.com/api/projects/37396",
		}

		PROJECT = SIMPLE_PROJECT.merge({
	    "project_group" =>
	    {
	    	"id" => 3768,
	    	"name" => "Sprockets, Inc.",
	    	"url" => "http://apitest.letsfreckle.com/api/project_groups/3768"
	    },
	    "minutes" => 180,
	    "billable_minutes" => 120,
	    "unbillable_minutes" => 60,
	    "invoiced_minutes" => 120,
	    "remaining_minutes" => 630,
	    "budget_minutes" => 750,

	    "import" => {
	    	"id" => 8910,
	    	"url" => "http://apitest.letsfreckle.com/api/imports/8910"
	    },

	    "invoices" => [
		    {
		    	"id" => 12345678,
		    	"invoice_number" => "AA001",
		    	"state" => "unpaid",
		    	"total" => 189.33,
		    	"url" => "http://apitest.letsfreckle.com/api/invoices/12345678",
		    }
	    ],

	    "participants" => [
	    	{
		    	"id" => 5538,
		    	"email" => "john.test@test.com",
		    	"first_name" => "John",
		    	"last_name" => "Test",
		    	"avatar" =>{
		    		"id" => 5538,
		    		"thumbnail" => "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
	  				"avatar" => "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
		    	},
		    	"url" => "http://apitest.letsfreckle.com/api/users/5538",
		    }
	    ],

	    "goals" => [
	    	{
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
		    		"url" => "http://apitest.letsfreckle.com/recurring_goals/8899"
		    	},
		    	"url" =>"http://apitest.letsfreckle.com/api/goals/445566"
		    }
	    ],

	    "recurring_goals" => [
    		{
	    		"id" => 8899,
	    		"renews" =>"yearly",
	    		"budgeted_minutes" => 1000,
	    		"starts_on" => "2001-01-02",
	    		"ends_on" => "2001-01-03",

	    		"goals" => [
	    			"id" => 445566,
			    	"budgeted_minutes" => 500,
			    	"total_logged_minutes" => 300,
			    	"billable_logged_minutes" => 200,
			    	"unbillable_logged_minutes" => 100,
			    	"starts_on" => "2001-01-02",
			    	"ends_on" => "2001-01-03",
			    	"url" =>"http://apitest.letsfreckle.com/api/goals/445566"
	    		],

	    		"url" => "http://apitest.letsfreckle.com/recurring_goals/8899"
	    	}
		  ],
	    "entries" => 0,
	    "entries_url" =>"http://apitest.letsfreckle.com/api/projects/34580/entries",
	    "expenses" => 0,
	    "expenses_url" => "http://apitest.letsfreckle.com/api/projects/34580/expenses",
	    "url" =>"http://apitest.letsfreckle.com/api/projects/34580",
	    "created_at" => "2012-01-09T08:33:29Z",
	    "updated_at" => "2012-01-09T08:33:29Z",
	  })

		SIMPLE_TAG = {
    	"id" => 249397,
      "name" => "freckle",
      "billable" => true,
      "url" => "http://apitest.letsfreckle.com/api/tags/249397"
    }

    TAG = SIMPLE_TAG.merge({
			"import" => {
				"id" => 8910,
				"url" => "http://apitest.letsfreckle.com/api/imports/8910"
			},
			"entries" => 0,
			"entries_url" => "http://apitest.letsfreckle.com/api/tags/55629/entries",

			"created_at" => "2010-06-09T20:44:57Z",
			"updated_at" => "2010-06-09T20:44:57Z",
    })

    SIMPLE_INVOICE = {
	  	"id" => 12345678,
	  	"invoice_number" => "AA001",
	  	"state" => "unpaid",
	  	"total" => 189.33,
	  	"url" => "http://apitest.letsfreckle.com/api/invoices/12345678",
	  }

	  SIMPLE_IMPORT = {
	  	"id" => 8910,
	  	"url" => "http://apitest.letsfreckle.com/api/imports/8910"
	  }

	  IMPORT = {
			"id" => 8910,
			"type" => "basecamp",
			"import_tags" => true,
			"autocreate_projects" => true,
			"user" => SIMPLE_USER,
			"fallback_user" => SIMPLE_USER,

			"status" => "completed",

			"report_url" => "http://apitest.letsfreckle.com/api/imports/8910/report",

			"entries" => 0,
			"entries_url" => "http://apitest.letsfreckle.com/api/imports/8910/entries",

			"tags" => 0,
			"tags_url" => "http://apitest.letsfreckle.com/api/imports/8910/tags",

			"projects" => 0,
			"projects_url" => "http://apitest.letsfreckle.com/api/imports/8910/projects",


			"url" => "http://apitest.letsfreckle.com/api/imports/8910",
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
		  "url" => "http://apitest.letsfreckle.com/api/entries/1711626",
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

	    "url" => "http://apitest.letsfreckle.com/api/expense/2233",
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
	end
end