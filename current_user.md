# Current User API
## Current User Object Specification
{
	"current_user":{
		"id": : 5538,
		"email": "john.test@test.com",
    "first_name": "John",
    "last_name": "Test",
    "avatar":{
      "id": 5538,
      "email": "john.test@test.com",
      "thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
      "avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
    },
    "state":"active",
    "role" : "admin",
    "time_format" : "fraction",
    "week_start": "Sunday",
    "utc_offset" : -28800,
    "send_personal_weekly_report_email": true,
    "send_team_weekly_report_email": true,

    "participating_projects": 0,
    "participating_projects_url" : "http://apitest.letsfreckle.com/api/users/5538/participating_projects",

    "accessible_projects": 0,
    "accessible_projects_url" : "http://apitest.letsfreckle.com/api/users/5538/accessible_projects",

    "entries": 0,
    "entries_url" : "http://apitest.letsfreckle.com/api/users/5538/entries",

    "expenses": 0,
    "expenses_url" : "http://apitest.letsfreckle.com/api/users/5538/entries",

    "url": "http://apitest.letsfreckle.com/api/users/5538",
    "created_at": "2010-06-09T20:44:57Z",
    "updated_at": "2010-06-09T20:44:57Z",
	}
}

## Add entries for current user
## Add expenses for current user
## Upload a new Avatar for current user
## Use a URL for a new Avatar for current user
## Use Twitter Profile Image for current user