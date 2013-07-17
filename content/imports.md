---
layout: default
title: Import
---

# Import API

## Import Object Specification

{
	"import" : {
		"id": 8910,
		"type": "basecamp",
		"import_tags": true,
		"autocreate_projects" : true,
		"user" : {
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
    },
		"fallback_user" : {
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
    },

    "report" : {
    	"entries_with_unknown_users" : 0,
    	"unknown_users": ["bob", "sue", "mary"],
    	"line_errors" : [
    		{
    			"line": 2,
    			"fields": [
    				"July 16, 2013",
    				"1 hour",
    				"bob"
    			],
    			"error" : "undefined method `+' for nil:NilClass"
    		}
    	],
    	"unknown_projects" : ["project 1", "project 2"],
    	"entries_discarded" : 223,
    	"entries_imported" : 48
    }

		"entries" : 0,
		"entries_url" : "http://apitest.letsfreckle.com/api/imports/8910/entries",

		"tags" : 0,
		"tags_url" : "http://apitest.letsfreckle.com/api/imports/8910/tags",

		"projects" : 0,
		"projects_url" : "http://apitest.letsfreckle.com/api/imports/8910/projects",


		"url": "http://apitest.letsfreckle.com/api/imports/8910"
		"created_at": "2010-06-09T20:44:57Z",
    "updated_at": "2010-06-09T20:44:57Z",
	}
}

## Importing Data
### Uploading the Import
### Checking an Import's status