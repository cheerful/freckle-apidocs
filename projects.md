#Project API

## Project Object Specification
	{
	  "project": {
	    // ID of the project (integer)
	    "id": 34580,
	    // Name of the project
	    "name": "Gear GmbH",
	    "project_group":
	    {
	    	"id": 3768,
	    	"name": "Sprockets, Inc.",
	    	"url": "http://apitest.letsfreckle.com/api/project_groups/3768"
	    },
	    // total amount of logged minutes (can be null)
	    "minutes": 180,
	    // total amount of logged billable minutes (can be null)
	    "billable_minutes": 120,
	    // total amount of unbillable minutes (can be null)
	    "unbillable_minutes": 60,
	    // total amount of logged invoiced minutes (can be null)
	    "invoiced_minutes": 120,
	    // amount of remaining minutes within budget (can be null)
	    "remaining_minutes": 630,
	    // budgeted minutes (can be null)
	    "budget_minutes": 750,
	    // true if project is billable
	    "billable": true,
	    // true if project is enabled, false if archived
	    "enabled": true,
	    // rrggbb hexadecimal color for the project
	    "color_hex": "ff9898",
	    // billing increment in minutes
	    // if you build client software that creates entries
	    // it should only allow multiples of stepping logged
	    // (in minutes). if the user enters a non-multiple you
	    // should round time up.
	    "stepping": 10,

	    // (optional) The import this entry was generated from
	    "import": {
	    	"id": 8910,
	    	"url": "http://apitest.letsfreckle.com/api/imports/8910"
	    },

	    //the invoices associated with this project
	    "invoices": [
		    {
		    	"id" : 12345678,
		    	"invoice_number": "AA001",
		    	"state": "unpaid",
		    	"total": 189.33,
		    	"url": "http://apitest.letsfreckle.com/api/invoices/12345678",
		    }
	    ]

	    //the participating users in the project
	    "participants": [
	    	{
		    	"id": : 5538,
		    	"first_name": "John",
		    	"last_name": "Test",
		    	"avatar":{
		    		"id": 5538,
		    		"thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
	  				"avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
		    	},
		    	"url": "http://apitest.letsfreckle.com/api/users/5538",
		    }
	    ]

	    "goals" : [
	    	{
		    	"id" : 445566,
		    	"budgeted_minutes": 500,
		    	"total_logged_minutes": 300,
		    	"billable_logged_minutes": 200,
		    	"unbillable_logged_minutes": 100,
		    	"starts_on": "2001-01-02",
		    	"ends_on": "2001-01-03",
		    	"recurring_goal":{
		    		"id": 8899,
		    		"renews":"yearly",
		    		"budgeted_minutes": 1000,
		    		"starts_on": "2001-01-02",
		    		"ends_on": "2001-01-03",
		    		"url": "http://apitest.letsfreckle.com/recurring_goals/8899"
		    	}
		    	"url":"http://apitest.letsfreckle.com/api/goals/445566"
		    }
	    ]

	    "recurring_goals": [
    		{
	    		"id": 8899,
	    		"renews":"yearly",
	    		"budgeted_minutes": 1000,
	    		"starts_on": "2001-01-02",
	    		"ends_on": "2001-01-03",

	    		"goals": [
	    			"id" : 445566,
			    	"budgeted_minutes": 500,
			    	"total_logged_minutes": 300,
			    	"billable_logged_minutes": 200,
			    	"unbillable_logged_minutes": 100,
			    	"starts_on": "2001-01-02",
			    	"ends_on": "2001-01-03",
			    	"url":"http://apitest.letsfreckle.com/api/goals/445566"
	    		]

	    		"url": "http://apitest.letsfreckle.com/recurring_goals/8899"
	    	}
		  ]

	    //the number of entries associated with this project
	    "entries": 0,
	    //the url to access this project's entries
	    "entries_url":"http://apitest.letsfreckle.com/api/projects/34580/entries",

	    //the number of expenses associated with this project
	    "expenses" : 0,
	    "expenses_url" : "http://apitest.letsfreckle.com/api/projects/34580/expenses",

	    //the url to this project
	    "url":"http://apitest.letsfreckle.com/api/projects/34580",

	    // UTC timestamp when the project was created
	    "created_at": "2012-01-09T08:33:29Z",
	    // UTC timestamp when the project was last updated
	    "updated_at": "2012-01-09T08:33:29Z",
	  }
	}

## List Projects

## List Entries for a project

## List Projects in Project Group

## List users who have logged entries in the project

## List entries in the project

## Get a single project

## Create a Project

## Edit a Project

## Delete a Project
