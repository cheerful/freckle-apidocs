---
layout: default
title: Project Group
---
# Project Group API

## Project Group Object Specification
	{
		"project_group":{
			"id": 3768,
    	"name": "Sprockets, Inc.",
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

      //the participating users in the project group
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

	  	"url": "http://apitest.letsfreckle.com/api/project_groups/3768",

	  	"entries_url" : "http://apitest.letsfreckle.com/api/project_groups/3768/entries/",

			"invoices_url" : "http://apitest.letsfreckle.com/api/project_groups/3768/invoices/",

			"projects_url" : "http://apitest.letsfreckle.com/api/project_groups/3768/projects/",

			// UTC timestamp when project group was created
	    "created_at": "2012-01-09T08:33:29Z",
	    // UTC timestamp when project group was last updated
	    "updated_at": "2012-01-09T08:33:29Z",
		},
	}

## List all Project Groups
## List Entries for a project group
## List Invoices for a project group
## List participants in a Project Group
## Add a Project to Group
## Remove a Project from Group
## Replace Projects in a Group
## Get a Project Group
## Edit a Project Group
## Delete a Project Group