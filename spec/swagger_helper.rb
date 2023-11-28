# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          BearerToken: {
            description: 'Auth0 bearer token',
            scheme: :bearer,
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        },
        schemas: {
          user: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withAuth0Id' },
              { '$ref' => '#/components/propertiesSchemas/userProperties' }
            ],
            required: %w[auth0Id username]
          },
          task: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/taskProperties' }
            ],
            required: %w[id title description done start end]
          },
          profile: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/profileProperties' }
            ],
            required: %w[id occupation prod_period start_work end_work start_sleep end_sleep]
          },
          tag: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/tagProperties' },
              { '$ref' => '#/components/additionalPropertiesSchemas/tagGlobalProperty' }
            ],
            required: %w[id name color global]
          },
          accessory: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/accessoryProperties' }
            ],
            required: %w[id name image_path body_part]
          },
          companion: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/companionProperties' }
            ],
            required: %w[id name skin_color]
          },
          room: {
            allOf: [
              { '$ref' => '#/components/idSchemas/withId' },
              { '$ref' => '#/components/propertiesSchemas/roomProperties' },
              { '$ref' => '#/components/additionalPropertiesSchemas/roomUserCountProperty' },
              { '$ref' => '#/components/additionalPropertiesSchemas/roomNeedsPasswordProperty' }
            ],
            required: %w[id name password capacity]
          }
        },
        idSchemas: {
          withAuth0Id: {
            type: 'object',
            properties: {
              auth0Id: { type: 'string' }
            }
          },
          withId: {
            type: 'object',
            properties: {
              id: { type: 'integer' }
            }
          }
        },
        propertiesSchemas: {
          userProperties: {
            type: 'object',
            properties: {
              username: { type: 'string' }
            }
          },
          taskProperties: {
            type: 'object',
            properties: {
              title: { type: 'string' },
              description: { type: 'string' },
              done: { type: 'boolean' },
              recurrence: { anyOf: [
                { type: 'array', items: { type: 'string', enum: %w[monday tuesday wednesday thursday friday saturday ] } },
                { type: 'string', pattern: 'yearly' }
              ], nullable: true },
              tags: { type: 'array', items: { type: 'integer' } },
              unmovable: { type: 'boolean' },
              start: { type: 'string', format: 'date-time', nullable: true },
              end: { type: 'string', format: 'date-time', nullable: true }
            }
          },
          profileProperties: {
            type: 'object',
            properties: {
              occupation: { type: 'string', enum: %w[school college work free] },
              prod_period: { type: 'string', enum: %w[before after both] },
              start_work: { type: 'string', format: 'date-time' },
              end_work: { type: 'string', format: 'date-time' },
              start_sleep: { type: 'string', format: 'date-time', nullable: true },
              end_sleep: { type: 'string', format: 'date-time', nullable: true },
            }
          },
          tagProperties: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              color: { type: 'string', pattern: '#[A-Fa-f0-9]{6}' }
            }
          },
          accessoryProperties: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              image_path: { type: 'string', pattern: '(/[a-z0-9_])+' },
              body_part: { type: 'string', enum: %w[hair hands face neck torso legs feet] }
            }
          },
          companionProperties: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              skin_color: { type: 'string', pattern: '#[A-Za-z0-9]{6}' },
              hair_id: { type: 'integer', nullable: true },
              face_id: { type: 'integer', nullable: true },
              neck_id: { type: 'integer', nullable: true },
              hands_id: { type: 'integer', nullable: true },
              torso_id: { type: 'integer', nullable: true },
              legs_id: { type: 'integer', nullable: true },
              feet_id: { type: 'integer', nullable: true }
            }
          },
          roomProperties: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              capacity: { type: 'integer' }
            }
          }
        },
        additionalPropertiesSchemas: {
          tagGlobalProperty: {
            type: 'object',
            properties: {
              global: { type: 'boolean' }
            }
          },
          roomPasswordProperty: {
            type: 'object',
            properties: {
              password: { type: 'string', nullable: true }
            }
          },
          roomUserCountProperty: {
            type: 'object',
            properties: {
              user_count: { type: 'integer' }
            }
          },
          roomNeedsPasswordProperty: {
            type: 'object',
            properties: {
              needs_password: { type: 'boolean' }
            }
          }
        }
      },
      security: [
        BearerToken: []
      ],
      servers: [
        {
          url: 'http://localhost:3000'
        },
        {
          url: 'https://etuduo-backend.herokuapp.com/'
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
