---
layout: default
title: Expense
---

# Expense API

## Expense Object Specification
{
	"expense" :{
		"id": 2233,
		"price" : 14.55,
		"description" : "new software",
		"apply_tax": true,
		"date" : "2010-06-09",

		"project": {
    	"id": 37396,
    	"name":"Gear GmbH",
    	"stepping": 10,
    	"enabled":  true,
    	"billable": true,
    	"color_hex": "ff9898",
    	"url": "http://apitest.letsfreckle.com/api/projects/37396",
  	},
  	"invoice": {
	    	"id" : 12345678,
	    	"invoice_number": "AA001",
	    	"state": "unpaid",
	    	"total": 189.33,
	    	"url": "http://apitest.letsfreckle.com/api/invoices/12345678",
	    },
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
    },

    "url": "http://apitest.letsfreckle.com/api/expense/2233",
		"created_at": "2010-06-09T20:44:57Z",
    "updated_at": "2010-06-09T20:44:57Z",
	}
}