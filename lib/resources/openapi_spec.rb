module Noko
  module Resources
    OPENAPI_VERSION = "3.0.0"
    SPEC_VERSION = "1.0.0"

    INFO = {
      "title": "Noko API v2",
      "description": "The JSON API for Noko Time Tracking",
      "termsOfService": "http://nokotime.com/terms/",
      "contact": {
        "name": "API Support",
        "url": "http://developer.nokotime.com",
        "email": "support@nokotime.com"
      },
      "version": SPEC_VERSION
    }

    SERVERS = [
      {
        "url": "https://api.nokotime.com/v2",
        "description": "API Endpoint"
      },
      {
        "url": "https://secure.nokotime.com/oauth/2",
        "description": "OAuth2 Web Application Flow Endpoint"
      }
    ]

    PERSONAL_ACCESS_TOKEN_SPEC = {
      "type": "apiKey",
      "name": "Personal Access Token",
      "in": "header"
    }

    OAUTH2_FLOW_SPEC = {
      "type": "oauth2",
      "flows": {
        "implicit": {
          "authorizationUrl": "#{OAUTH2_URL}/oauth/2/authorize",
          "tokenUrl": "#{OAUTH2_URL}/oauth/2/access_token",
          "refreshUrl": "#{OAUTH2_URL}/oauth/2/access_token",
        },
        "authorizationCode": {
          "authorizationUrl": "#{OAUTH2_URL}/oauth/2/authorize",
          "tokenUrl": "#{OAUTH2_URL}/oauth/2/access_token",
          "refreshUrl": "#{OAUTH2_URL}/oauth/2/access_token",
        }
      }
    }
  end
end