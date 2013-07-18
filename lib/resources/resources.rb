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

		SIMPLE_TAG = {
    	"id" => 249397,
      "name" => "freckle",
      "billable" => true,
      "url" => "http://apitest.letsfreckle.com/api/tags/249397"
    }

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