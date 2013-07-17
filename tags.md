---
layout: default
title: Tag
---
# Tag API

## Tag Object Specification

	{
	  "tag": {
	  	"id": 55629
	  	//the text of the tag
	    "name": "meeting",
	    //the boolean indicating whether the tag is considered billable
	    "billable": true,

	    "import": {
	    	"id": 8910,
	    	"url": "http://apitest.letsfreckle.com/api/imports/8910"
	    },

	    //the number of entries which include this tag
	    "entries": 0,
	    "entries_url": "http://apitest.letsfreckle.com/api/tags/55629/entries",

	    "url": "http://apitest.letsfreckle.com/api/tags/55629"
	    "created_at": "2010-06-09T20:44:57Z",
	    "updated_at": "2010-06-09T20:44:57Z",
	  }
	}

## List all Tags

## List all entries for a tag