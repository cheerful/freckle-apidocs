module Noko
  module Resources
    OPENAPI_VERSION = "3.1.0"
    SPEC_VERSION = "0.0.1"

    ENTRIES_TAG = "Entries"
    PROJECTS_TAG = "Projects"
    WEBHOOKS_TAG = "Webhooks"

    ENTRIES_SCHEMA_REF = { "$ref": "#/components/schemas/Entries" }
    PROJECTS_SCHEMA_REF = { "$ref": "#/components/schemas/Projects" }
    ENTRY_SCHEMA_REF = { "$ref": "#/components/schemas/Entry" }
    PROJECT_SCHEMA_REF = { "$ref": "#/components/schemas/Project" }

    SIMPLE_USER_SCHEMA_REF = { "$ref": "#/components/schemas/UserSummary" }
    SIMPLE_PROJECT_GROUP_SCHEMA_REF = { "$ref": "#/components/schemas/ProjectGroupSummary" }
    SIMPLE_PROJECT_SCHEMA_REF = { "$ref": "#/components/schemas/ProjectSummary" }

    TAG_SCHEMA_REF = { "$ref": "#/components/schemas/Tag" }


    SUMMARY_PROJECT_LINK_TO_PROJECT_REF = {"$ref": '#/components/links/LinkToProjectFromSummaryProject'}

    BILLING_INCREMENT_ENUM_REF = {"$ref": "#/components/schemas/BillingIncrement"}
    WEBHOOK_EVENT_SCHEMA_REF = { "$ref": "#/components/schemas/WebhookEvent" }
    NEW_WEBHOOK_SCHEMA_REF = { "$ref": "#/components/schemas/NewWebhook" }
    WEBHOOK_SCHEMA_REF = { "$ref": "#/components/schemas/Webhook" }
    WEBHOOK_PAYLOAD_SCHEMA_REF = {"$ref": "#/components/schemas/WebhookPayload"}
    WEBHOOK_PAYLOAD_CALLBACKS_SCHEMA_REF = { "$ref": "#/components/schemas/WebhookPayloadCallbacks" }
    ENTRY_EXAMPLE_REF = { "$ref": "#/components/examples/Entry" }

    ID_PROPERTY = {type: "integer", format: "integer", example: 1234}
    DATE_PROPERTY = {type: "string", format: "date"}
    BOOLEAN_PROPERTY = {type: "boolean"}

    def content(content)
      return {
        "application/json": content
      }
    end

    def webhook_callback(summary:, description:, schema:)
      return {
        "$request.body#payload_uri": {
          post: {
            summary: summary,
            requestBody: {
              description: description,
              content: content(schema: schema),
            },
            "responses": {
              "200": { "$ref": '#/components/responses/WebhookPayload200Response'},
              "202": { "$ref": '#/components/responses/WebhookPayload202Response'},
              "410": { "$ref": '#/components/responses/WebhookPayload410Response'},
              "500": { "$ref": '#/components/responses/WebhookPayload500Response'},
              "501": { "$ref": '#/components/responses/WebhookPayload501Response'},
            },
            tags: [WEBHOOKS_TAG]
          },
        }
      }
    end

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
              schema: {
                "type": "string"
              }
            }
          ],
          responses: {
            "200": {
              description: "A paged array of entries",
              content: {
                "application/json": {
                  schema: ENTRIES_SCHEMA_REF
                }
              },
              links: {
                "Project": SUMMARY_PROJECT_LINK_TO_PROJECT_REF
              }
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
              schema: {type: "string", example: "Gear"}
            }
          ],
          "responses": {
            "200": {
              description: "A paged array of projects",
              content: content(schema: PROJECTS_SCHEMA_REF)
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
              schema: {
                "type": "integer"
              }
            }
          ],
          "responses": {
            "200": {
              description: "A single project",
              content: content(schema: PROJECT_SCHEMA_REF)
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
          requestBody: {
            "description": "subscribe a Webhook to receive events from Noko",
            content: {
              "application/json": {
                schema: NEW_WEBHOOK_SCHEMA_REF
              }
            }
          },
          responses: {
            "201": {
              description: "Webhook successfully created",
              content: {
                "application/json": {
                  schema: WEBHOOK_SCHEMA_REF
                }
              }
            }
          },
          callbacks: {
            "entry-created": webhook_callback(summary: "Entry Created", description: "An entry has been created in Noko", schema: {"$ref" => "#/components/schemas/EntryCreatedWebhookPayload"}),
            "entry-updated": webhook_callback(summary: "Entry Updated", description: "An entry has been updated in Noko", schema: {"$ref" => "#/components/schemas/EntryUpdatedWebhookPayload"}),
            "entry-approved": webhook_callback(summary: "Entry Approved", description: "An entry has been approved in Noko", schema: {"$ref" => "#/components/schemas/EntryApprovedWebhookPayload"}),
            "entry-unapproved": webhook_callback(summary: "Entry Unapproved", description: "An entry has been unapproved in Noko", schema: {"$ref" => "#/components/schemas/EntryUnapprovedWebhookPayload"}),
            "entry-invoiced": webhook_callback(summary: "Entry Invoiced", description: "An entry has been invoiced in Noko", schema: {"$ref" => "#/components/schemas/EntryInvoicedWebhookPayload"}),
            "entry-uninvoiced": webhook_callback(summary: "Entry Uninvoiced", description: "An entry has been uninvoiced in Noko", schema: {"$ref" => "#/components/schemas/EntryUninvoicedWebhookPayload"}),
            "entry-deleted": webhook_callback(summary: "Entry Deleted", description: "An entry has been deleted in Noko", schema: {"$ref" => "#/components/schemas/EntryDeletedWebhookPayload"}),
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


    ENTRY_EXAMPLE = {
      Entry: {
        summary: "A single time entry",
        value: ENTRY
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
        summary: "The list of projects from Noko",
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
            type: "sting"
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
        enum: WEBHOOK_ENTRY_EVENTS + WEBHOOK_TAG_EVENTS + ["*"],
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
            example: EXAMPLE_WEBHOOK_SUMMARY["name"],
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

    WEBHOOK_PAYLOAD_CALLBACKS_SCHEMA = {
      WebhookPayload: {
        type: "object",
        description: "A Webhook Payload",
        required: ["id", "type", "created_at", "object"],
        properties: {
          id: {type: "string", format: "uuid"},
          created_at: {type: "string", format: "date-time"},
        }
      },

      EntryCreatedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is created",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.created"]},
              object: ENTRY_SCHEMA_REF
            }
          },
          {"$ref": '#/components/schemas/WebhookPayload'},
        ]
      },

      EntryUpdatedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is updated",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.updated"]},
              object: ENTRY_SCHEMA_REF
            }
          },
          {"$ref": '#/components/schemas/WebhookPayload'},
        ]
      },

      EntryApprovedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is approved",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.updated.approved"]}
            }
          },
          {"$ref": '#/components/schemas/EntryUpdatedWebhookPayload'},
        ]
      },

      EntryUnapprovedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is unapproved",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.updated.unapproved"]}
            }
          },
          {"$ref": '#/components/schemas/EntryUpdatedWebhookPayload'},
        ]
      },


      EntryInvoicedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is invoiced",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.updated.invoiced"]}
            }
          },
          {"$ref": '#/components/schemas/EntryUpdatedWebhookPayload'},
        ]
      },

      EntryUninvoicedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is uninvoiced",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.updated.uninvoiced"]}
            }
          },
          {"$ref": '#/components/schemas/EntryUpdatedWebhookPayload'},
        ]
      },

      EntryDeletedWebhookPayload: {
        allOf: [
          {
            type: "object",
            description: "The Webhook Payload for when an entry is deleted",
            properties: {
              type: {type: "WebhookEvent", enum: ["entry.deleted"]},
              object: ENTRY_SCHEMA_REF
            }
          },
          {"$ref": '#/components/schemas/WebhookPayload'},
        ]
      },
    }

    WEBHOOK_PAYLOAD_RESPONSES = {
      "WebhookPayload200Response":{
        "description": "Your webhook should return `#{Noko::HTTPHeaders::Helpers::STATUSES[200]}` if the payload was received successfully."
      },
      "WebhookPayload202Response": {
        "description": "Your webhook should return `#{Noko::HTTPHeaders::Helpers::STATUSES[202]}` if the payload was received successfully, but will not be acted on."
      },

      "WebhookPayload410Response": {
        "description": "Your webhook should return `#{Noko::HTTPHeaders::Helpers::STATUSES[410]}` if the webhook has been removed or disabled. This will disable the webhook in Noko and stop it from sending future events."
      },

      "WebhookPayload500Response": {
        "description": "Your webhook should return `#{Noko::HTTPHeaders::Helpers::STATUSES[500]}` if you encountered an error processing the webhook."
      },

      "WebhookPayload501Response": {
        "description": "Your webhook should return `#{Noko::HTTPHeaders::Helpers::STATUSES[501]}` if you have not implemented this event yet."
      },
    }

    BILLING_INCREMENT_ENUM = {
      BillingIncrement: {
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
      "flows": {
        "implicit": {
          "authorizationUrl": "#{OAUTH2_URL}/oauth/2/authorize",
          "refreshUrl": "#{OAUTH2_URL}/oauth/2/access_token",
        },
        "authorizationCode": {
          "authorizationUrl": "#{OAUTH2_URL}/oauth/2/authorize",
          "tokenUrl": "#{OAUTH2_URL}/oauth/2/access_token",
          "refreshUrl": "#{OAUTH2_URL}/oauth/2/access_token",
        }
      }
    }

    PATHS = ENTRY_PATHS.merge(PROJECT_PATHS).merge(WEBHOOK_PATHS)
    RESPONSES = WEBHOOK_PAYLOAD_RESPONSES
    SECURITY = [{"oauth2": [], "personal_access_token": []}]
    LINKS = SUMMARY_PROJECT_LINK_TO_PROJECT

    SCHEMAS = ENTRY_SCHEMA.merge(ENTRIES_SCHEMA).merge(PROJECT_SCHEMA).merge(PROJECTS_SCHEMA).merge(SIMPLE_PROJECT_GROUP_SCHEMA).merge(SIMPLE_USER_SCHEMA).merge(SIMPLE_PROJECT_SCHEMA).merge(TAG_SCHEMA).merge(BILLING_INCREMENT_ENUM).merge(WEBHOOK_EVENT_SCHEMA).merge(NEW_WEBHOOK_SCHEMA).merge(WEBHOOK_SCHEMA).merge(WEBHOOK_PAYLOAD_CALLBACKS_SCHEMA)
    EXAMPLES = ENTRY_EXAMPLE

    COMPONENTS = {
      responses: RESPONSES,
      schemas: SCHEMAS,
      examples: EXAMPLES,
      links: LINKS,
      securitySchemes: {
        "oauth2": OAUTH2_FLOW_SPEC,
        "personal_access_token": PERSONAL_ACCESS_TOKEN_SPEC
      }
    }

    OPENAPI_SPEC = {
      "openapi" => OPENAPI_VERSION,
      "info" => INFO,
      "servers" => SERVERS,
      "paths" => PATHS,
      "security" => SECURITY,
      "components" => COMPONENTS
    }
  end
end