module Noko
  module Resources
    OPENAPI_VERSION = "3.1.0"
    SPEC_VERSION = "0.1.0"

    ENTRIES_SCHEMA_REF = { "$ref": "#/components/schemas/Entries" }
    ENTRY_SCHEMA_REF = { "$ref": "#/components/schemas/Entry" }
    TAG_SCHEMA_REF = { "$ref": "#/components/schemas/Tag" }
    WEBHOOK_EVENT_SCHEMA_REF = { "$ref": "#/components/schemas/WebhookEvent" }
    NEW_WEBHOOK_SCHEMA_REF = { "$ref": "#/components/schemas/NewWebhook" }
    WEBHOOK_SCHEMA_REF = { "$ref": "#/components/schemas/Webhook" }
    WEBHOOK_PAYLOAD_SCHEMA_REF = {"$ref": "#/components/schemas/WebhookPayload"}
    WEBHOOK_PAYLOAD_CALLBACKS_SCHEMA_REF = { "$ref": "#/components/schemas/WebhookPayloadCallbacks" }
    ENTRY_EXAMPLE_REF = { "$ref": "#/components/examples/Entry" }


    ID_PROPERTY = {type: "integer", format: "int64", readOnly: true}
    DATE_PROPERTY = {type: "string", format: "date"}

    ENTRY_PATHS = {
      "/entries": {
        get: {
          summary: "Get all entries, sorted by the most recent entry date.",
          operationId: "listEntries",
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
              }
            }
          }
        }
      }
    }

    def self.webhook_callback(summary:, description:, schema:)
      return {
        "$request.body#payload_uri": {
          post: {
            summary: summary,
            requestBody: {
              description: description,
              content: {
                "application/json": {
                  schema: schema
                }
              }
            }
          }
        }
      }
    end


    WEBHOOK_PATHS = {
      "/webhooks": {
        post: {
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
            entryCreated: webhook_callback(summary: "Entry Created", description: "An entry has been created in Noko", schema: {"$ref" => "#/components/schemas/EntryCreatedWebhookPayload"}),
            entryUpdated: webhook_callback(summary: "Entry Updated", description: "An entry has been updated in Noko", schema: {"$ref" => "#/components/schemas/EntryUpdatedWebhookPayload"}),
            entryApproved: webhook_callback(summary: "Entry Approved", description: "An entry has been approved in Noko", schema: {"$ref" => "#/components/schemas/EntryApprovedWebhookPayload"}),
            entryUnapproved: webhook_callback(summary: "Entry Unapproved", description: "An entry has been unapproved in Noko", schema: {"$ref" => "#/components/schemas/EntryUnapprovedWebhookPayload"}),
          }
        }
      }
    }

    ENTRY_SCHEMA = {
      Entry: {
        required: [
          "id",
          "date",
          "minutes"
        ],
        properties: {
          id: ID_PROPERTY,
          date: DATE_PROPERTY,
          minutes: {type: "integer", format: "int64"}
        },
        example: ENTRY
      },
    }

    ENTRIES_SCHEMA = {
      Entries: {
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
          billable: {
            type: "boolean"
          },
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
              type: {type: "WebhookEvent", enum: ["entry.updated.approved"]},
              object: ENTRY_SCHEMA_REF
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
              type: {type: "WebhookEvent", enum: ["entry.updated.unapproved"]},
              object: ENTRY_SCHEMA_REF
            }
          },
          {"$ref": '#/components/schemas/EntryUpdatedWebhookPayload'},
        ]
      },
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

    PATHS = ENTRY_PATHS.merge(WEBHOOK_PATHS)
    SECURITY = [OAUTH2_FLOW_SPEC, PERSONAL_ACCESS_TOKEN_SPEC]
    SCHEMAS = ENTRY_SCHEMA.merge(ENTRIES_SCHEMA).merge(TAG_SCHEMA).merge(WEBHOOK_EVENT_SCHEMA).merge(NEW_WEBHOOK_SCHEMA).merge(WEBHOOK_SCHEMA).merge(WEBHOOK_PAYLOAD_CALLBACKS_SCHEMA)
    EXAMPLES = ENTRY_EXAMPLE

    COMPONENTS = {
      schemas: SCHEMAS,
      examples: EXAMPLES,
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