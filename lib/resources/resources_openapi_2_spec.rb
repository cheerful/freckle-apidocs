module Noko
  module Resources
    module OpenAPI2
      SWAGGER_VERSION = "2.0"
      SPEC_VERSION = "0.0.1"

      ENTRIES_TAG = "Entries"
      PROJECTS_TAG = "Projects"
      WEBHOOKS_TAG = "Webhooks"

      ENTRIES_SCHEMA_REF = { "$ref": "#/definitions/Entries" }
      PROJECTS_SCHEMA_REF = { "$ref": "#/definitions/Projects" }
      ENTRY_SCHEMA_REF = { "$ref": "#/definitions/Entry" }
      PROJECT_SCHEMA_REF = { "$ref": "#/definitions/Project" }

      SIMPLE_USER_SCHEMA_REF = { "$ref": "#/definitions/UserSummary" }
      SIMPLE_PROJECT_GROUP_SCHEMA_REF = { "$ref": "#/definitions/ProjectGroupSummary" }
      SIMPLE_PROJECT_SCHEMA_REF = { "$ref": "#/definitions/ProjectSummary" }

      TAG_SCHEMA_REF = { "$ref": "#/definitions/Tag" }

      BILLING_INCREMENT_ENUM_REF = {"$ref": "#/definitions/BillingIncrement"}
      WEBHOOK_EVENT_SCHEMA_REF = { "$ref": "#/definitions/WebhookEvent" }
      NEW_WEBHOOK_SCHEMA_REF = { "$ref": "#/definitions/NewWebhook" }
      WEBHOOK_SCHEMA_REF = { "$ref": "#/definitions/Webhook" }
      WEBHOOK_PAYLOAD_SCHEMA_REF = {"$ref": "#/definitions/WebhookPayload"}

      ID_PROPERTY = {type: "integer", format: "integer", example: 1234}
      DATE_PROPERTY = {type: "string", format: "date"}
      BOOLEAN_PROPERTY = {type: "boolean"}

      ENTRY_PATHS = {
        "/entries": {
          get: {
            summary: "Get all entries, sorted by the most recent entry date.",
            operationId: "list-entries",
            parameters: [
              {
                name: "user_ids",
                in: "query",
                description: "A comma-separated list of user IDs to filter by",
                required: false,
                "type": "string"
              }
            ],
            responses: {
              "200": {
                description: "A paged array of entries",
                schema: ENTRIES_SCHEMA_REF
              }
            },
            tags: [ENTRIES_TAG]
          }
        }
      }

      PROJECT_PATHS = {
        "/projects": {
          get: {
            summary: "List all projects the authenticated user has access to.",
            operationId: "list-projects",
            parameters: [
              {
                name: "name",
                in: "query",
                description: "Only projects containing this text in their name are returned.",
                required: false,
                type: "string"
              }
            ],
            "responses": {
              "200": {
                description: "A paged array of projects",
                schema: PROJECTS_SCHEMA_REF
              }
            },
            tags: [PROJECTS_TAG],
          },
        },
        '/projects/#{id}': {
          get: {
            summary: "Get a single project",
            operationId: "get-project",
            parameters: [
              {
                name: "id",
                in: "path",
                description: "The ID of the project to retrieve",
                required: true,
                "type": "integer"
              }
            ],
            "responses": {
              "200": {
                description: "A single project",
                schema: PROJECT_SCHEMA_REF
              }
            },
            tags: [PROJECTS_TAG],
          }
        }
      }

      WEBHOOK_PATHS = {
        "/webhooks": {
          post: {
            operationId: "add-webhook",
            summary: "Create a Webhook to listen to events from Noko",
            parameters: [
              name: "body",
              in: "body",
              schema: NEW_WEBHOOK_SCHEMA_REF
            ],
            responses: {
              "201": {
                description: "Webhook successfully created",
                schema: WEBHOOK_SCHEMA_REF
              }
            },
            tags: [WEBHOOKS_TAG]
          }
        }
      }

      SIMPLE_USER_SCHEMA = {
        UserSummary: {
          description: "A Summary of a User",
          type: "object",
          required: ["id", "email"],
          properties: {
            id: ID_PROPERTY,
            email: { type: "string", format: "email", example: SIMPLE_USER["email"] }
          }
        }
      }

      SIMPLE_PROJECT_SCHEMA = {
        ProjectSummary: {
          description: "A Summary of a Project",
          type: "object",
          required: ["id", "name", "enabled", "billing_increment", "color", "billable"],
          properties: {
            id: ID_PROPERTY,
            name: {type: "string", example: SIMPLE_PROJECT["name"]},
            enabled: BOOLEAN_PROPERTY,
            billing_increment: BILLING_INCREMENT_ENUM_REF,
            color: {type: "string", format: "CSS Hexadecimal color", example: SIMPLE_PROJECT["color"]},
            billable: BOOLEAN_PROPERTY,
          }
        }
      }

      ENTRY_SCHEMA = {
        Entry: {
          description: "Entry",
          type: "object",
          required: [
            "id",
            "date",
            "minutes"
          ],
          properties: {
            id: ID_PROPERTY,
            date: DATE_PROPERTY,
            minutes: {type: "integer", format: "integer", description: "The number of minutes logged in this time entry. This number will automatically be rounded up based on the project's `billing_increment` settings. If no value is provided, then the entry will have `0` minutes."},
            user: SIMPLE_USER_SCHEMA_REF,
            project: SIMPLE_PROJECT_SCHEMA_REF,
            description: {type: "string", description: "The description of the time entry, including any hashtags."},
            tags: {
              type: "array",
              items: TAG_SCHEMA_REF
            },

            approved_by: SIMPLE_USER_SCHEMA_REF,
          },
          example: ENTRY
        },
      }

      ENTRIES_SCHEMA = {
        Entries: {
          description: "The list of entries from Noko",
          type: "array",
          items: ENTRY_SCHEMA_REF
        }
      }

      PROJECT_SCHEMA = {
        Project: {
          description: "A Project in Noko",
          type: "object",
          required: ["id", "name", "enabled", "billing_increment", "color", "billable"],
          properties: {
            id: ID_PROPERTY,
            name: {type: "string", example: SIMPLE_PROJECT["name"]},
            enabled: BOOLEAN_PROPERTY,
            billing_increment: BILLING_INCREMENT_ENUM_REF,
            color: {type: "string", format: "CSS Hexadecimal color", example: SIMPLE_PROJECT["color"]},
            billable: BOOLEAN_PROPERTY,
            project_group: SIMPLE_PROJECT_GROUP_SCHEMA_REF,
          }
        }
      }

      PROJECTS_SCHEMA = {
        Projects: {
          description: "The list of projects from Noko",
          type: "array",
          items: PROJECT_SCHEMA_REF
        }
      }

      SIMPLE_PROJECT_GROUP_SCHEMA = {
        ProjectGroupSummary: {
          description: "A Summary of a Project Group",
          required: ["id", "name"],
          properties: {
            id: ID_PROPERTY,
            name: {type: "string", example: SIMPLE_PROJECT_GROUP["name"]}
          },
        }
      }


      SUMMARY_PROJECT_LINK_TO_PROJECT = {
        LinkToProjectFromSummaryProject: {
          operationId: "get-project",
          parameters: {
            id: "$response.body#/project.id"
          }
        },
      }

      TAG_SCHEMA = {
        Tag: {
          required: [
            "id", "name", "billable", "formatted_name"
          ],
          properties: {
            id: ID_PROPERTY,
            name: {
              type: "string"
            },
            billable: BOOLEAN_PROPERTY,
            formatted_name: {
              type: "string"
            }
          },
          example: TAG
        }
      }


      WEBHOOK_EVENT_SCHEMA = {
        WebhookEvent: {
          type: "string",
          enum: Noko::Resources::WEBHOOK_ENTRY_EVENTS + Noko::Resources::WEBHOOK_TAG_EVENTS + ["*"],
          default: "*"
        }
      }

      NEW_WEBHOOK_SCHEMA = {
        NewWebhook: {
          description: "A new Webhook to subscribe to Noko",
          required: ["id", "name", "payload_uri", "events"],
          properties: {
            id: ID_PROPERTY,
            name: {
              description: "The name of the Webhook",
              type: "string",
              example: EXAMPLE_WEBHOOK_SUMMARY[:name],
            },

            payload_uri: {
              description: "The URI to send the payloads to",
              type: "string",
              format: "uri",
              example: EXAMPLE_WEBHOOK_PAYLOAD_URI,
            },

            events: {
              description: "The events this webhook should be subscribed to. You can also specify `'*'`, which is a wildcard for all current and future events.",
              type: "array",
              items: WEBHOOK_EVENT_SCHEMA_REF
            }
          }
        }
      }

      WEBHOOK_SCHEMA = {
        Webhook: {
          description: "A Webhook",
          required: ["id", "name", "payload_uri"],
          properties: {
            id: ID_PROPERTY,
            name: {
              description: "The name of the Webhook",
              type: "string",
              example: EXAMPLE_WEBHOOK_SUMMARY[:name],
            },

            payload_uri: {
              description: "The URI to send the payloads to",
              type: "string",
              format: "uri",
              example: EXAMPLE_WEBHOOK_PAYLOAD_URI,
            }
          },
          example: WEBHOOK,
        }
      }

      BILLING_INCREMENT_ENUM = {
        BillingIncrement: {
          type: "string",
          description: "The billing increment used by this project. The default value is the account's default billing increment (which is `15` by default).",
          enum: [1, 5, 6, 10, 15, 2, 30, 60],
          default: 15,
        }
      }

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
        }
      ]

      PERSONAL_ACCESS_TOKEN_SPEC = {
        "type": "apiKey",
        "name": "X-NokoToken",
        "in": "header",
      }

      OAUTH2_FLOW_SPEC = {
        "type": "oauth2",
        flow: "accessCode",
        "authorizationUrl": "#{OAUTH2_URL}/oauth/2/authorize",
        "tokenUrl": "#{OAUTH2_URL}/oauth/2/access_token",
        "scopes": {}
      }

      PATHS = ENTRY_PATHS.merge(PROJECT_PATHS).merge(WEBHOOK_PATHS)
      SECURITY = [{"oauth2": [], "personal_access_token": []}]
      LINKS = SUMMARY_PROJECT_LINK_TO_PROJECT

      SCHEMAS = ENTRY_SCHEMA.merge(ENTRIES_SCHEMA).merge(PROJECT_SCHEMA).merge(PROJECTS_SCHEMA).merge(SIMPLE_PROJECT_GROUP_SCHEMA).merge(SIMPLE_USER_SCHEMA).merge(SIMPLE_PROJECT_SCHEMA).merge(TAG_SCHEMA).merge(BILLING_INCREMENT_ENUM).merge(WEBHOOK_EVENT_SCHEMA).merge(NEW_WEBHOOK_SCHEMA).merge(WEBHOOK_SCHEMA)

      OPENAPI_2_SPEC = {
        "swagger" => SWAGGER_VERSION,
        "info" => INFO,
        "host" => BASE_DOMAIN,
        "basePath" => "/v2/",
        schemes: ["https"],
        "paths" => PATHS,
        "security" => SECURITY,
        definitions: SCHEMAS,
        securityDefinitions: {
          "oauth2": OAUTH2_FLOW_SPEC,
          "personal_access_token": PERSONAL_ACCESS_TOKEN_SPEC
        }
      }
    end
  end
end