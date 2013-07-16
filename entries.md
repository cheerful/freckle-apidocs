# Entry API

## Entry Object Specification
Here is an example of an Entry object returned by the API

	{
	  "entry": {
	    // ID of the entry (integer)
	    "id": 1711626,

	    // date the time is logged for YYYY-MM-DD
	    "date": "2012-01-09",
	    // User the time is logged for
	    "user":{
	    	"id": : 5538,
	    	"email": "john.test@test.com",
	    	"first_name": "John",
	    	"last_name": "Test",
	    	"avatar":{
	    		"id": 5538,
	    		"thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
  				"avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
	    	},
	    	"url": "http://apitest.letsfreckle.com/api/users/5538",
	    }

	    // false if entry or project are unbillable
	    "billable": true,
	    // logged time in minutes (integer)
	    "minutes": 60,
	    // full description text (includes tags)
	    "description": "freckle",

	    // All following fields are OPTIONAL
	    // (optional) the project this entry was created for
	    "project": {
	    	"id": 37396,
	    	"name":"Gear GmbH",
	    	"stepping": 10,
	    	"enabled":  true,
	    	"billable": true,
	    	"color_hex": "ff9898",
	    	"url": "http://apitest.letsfreckle.com/api/projects/37396",
    	},
	    // (optional) array of tags assigned to entry
	    "tags": [
	      {
	      	"id": 249397,
	        "name": "freckle",
	        "billable": true,
	        "url": "http://apitest.letsfreckle.com/api/tags/249397"
	      }
	    ],
	    // (optional) link to the source of the entry (e.g. Github commit)
	    "source_url": null,
	    // (optional) UTC timestamp when entry was added to an invoice
	    "invoiced_at": "2012-01-10T08:33:29Z",
	    // (optional) The invoice this project has been assigned to
	    "invoice": {
	    	"id" : 12345678,
	    	"invoice_number": "AA001",
	    	"state": "unpaid",
	    	"total": 189.33,
	    	"url": "http://apitest.letsfreckle.com/api/invoices/12345678",
	    }
	    // (optional) The import this entry was generated from
	    "import": {
	    	"id": 8910,
	    	"url": "http://apitest.letsfreckle.com/api/imports/8910"
	    },
	    //a url to this entry
	    "url": "http://apitest.letsfreckle.com/api/entries/1711626"

	    // UTC timestamp when entry was created
	    "created_at": "2012-01-09T08:33:29Z",
	    // UTC timestamp when entry was last updated
	    "updated_at": "2012-01-09T08:33:29Z",
	  }
	}

## List Entries

## Get a single Entry

## Create an Entry

## Edit an Entry

## Delete an Entry