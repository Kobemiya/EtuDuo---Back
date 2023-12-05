require 'swagger_helper'

RSpec.describe 'rooms', type: :request do

  path '/rooms' do

    get('list rooms') do
      tags 'Rooms'
      produces 'application/json'
      description 'List all rooms'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/room' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('create room') do
      tags 'Rooms'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a room with optional password'

      parameter name: :body, description: 'Rooms infos', in: :body,
                schema: {
                  allOf: [
                    { '$ref' => '#/components/propertiesSchemas/roomProperties' },
                    { '$ref' => '#/components/additionalPropertiesSchemas/roomPasswordProperty'}
                  ],
                  required: %w[name password capacity]
                }

      response(200, 'Created') do
        schema '$ref' => '#/components/schemas/room'
        run_test!
      end
      response(400, 'Bad Request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/rooms/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get('show room') do
      tags 'Rooms'
      produces 'application/json'
      description 'Get room\'s info by id'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/room'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not Found') do run_test! end
    end

    patch('update room') do
      tags 'Rooms'
      consumes 'application/json'
      produces 'application/json'
      description 'Get room\'s info by id'

      parameter name: :body, description: 'Rooms infos', in: :body,
                schema: {
                  allOf: [
                    { '$ref' => '#/components/propertiesSchemas/roomProperties' },
                    { '$ref' => '#/components/additionalPropertiesSchemas/roomPasswordProperty'}
                  ]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/room'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    put('update room') do
      tags 'Rooms'
      consumes 'application/json'
      produces 'application/json'
      description 'Get room\'s info by id'

      parameter name: :body, description: 'Rooms infos', in: :body,
                schema: {
                  allOf: [
                    { '$ref' => '#/components/propertiesSchemas/roomProperties' },
                    { '$ref' => '#/components/additionalPropertiesSchemas/roomPasswordProperty'}
                  ]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/room'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    delete('delete room') do
      tags 'Rooms'
      description 'Delete room by id'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
    end
  end
<<<<<<< HEAD
=======

  path '/rooms/enter/{room_id}' do
    parameter name: 'room_id', in: :path, type: :integer, description: 'room_id'

    post('enter room') do
      tags 'Rooms'
      consumes 'application/json'
      description 'Enter room using id and password'

      parameter name: :body, description: 'Identification info', in: :body,
                schema: { type: 'object', properties: { password: { type: 'string' } }, required: %w[password] }

      response(200, 'Successful') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Wrong password') do run_test! end
      response(409, 'Room full') do run_test! end
      response(409, 'Already joined') do run_test! end
    end
  end

  path '/rooms/leave/{room_id}' do
    parameter name: 'room_id', in: :path, type: :integer, description: 'room_id'

    post('leave room') do
      tags 'Rooms'
      description 'Leave room using id'

      response(200, 'Successful') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(405, 'Host not allowed to leave') do run_test! end
      response(409, 'Already left') do run_test! end
    end
  end
>>>>>>> 8d6d96b (Added capacity and user_count to rooms in DB and endpoints, with Swagger doc)
end
