---
layout: default
title: User
---

# User API

## User Object Specification

{
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
    "state":"active",
    "role" : "member",

    "participating_projects": 0,
    "participating_projects_url" : "http://apitest.letsfreckle.com/api/users/5538/participating_projects",

    "accessible_projects": 0,
    "accessible_projects_url" : "http://apitest.letsfreckle.com/api/users/5538/accessible_projects",

    "entries": 0,
    "entries_url" : "http://apitest.letsfreckle.com/api/users/5538/entries",

    "expenses": 0,
    "expenses_url" : "http://apitest.letsfreckle.com/api/users/5538/entries",

    "add_project_access" : "http://apitest.letsfreckle.com/api/users/5538/project_access/add",
    "remove_project_access" : "http://apitest.letsfreckle.com/api/users/5538/project_access/remove",

    "url": "http://apitest.letsfreckle.com/api/users/5538",
    "created_at": "2010-06-09T20:44:57Z",
    "updated_at": "2010-06-09T20:44:57Z",
  }
}

## Give User Access to a Project
## Revoke User Access to a Project