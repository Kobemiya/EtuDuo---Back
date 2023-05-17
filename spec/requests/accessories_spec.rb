require 'swagger_helper'

RSpec.describe 'accessories', type: :request do

  path '/accessories' do

    get('list accessories') do
      tags 'Accessories'
      produces 'application/json'
      description 'List all accessories in the game'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/accessory' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('create accessory') do
      tags 'Accessories'
      produces 'application/json'
      consumes 'application/json'
      description 'Create a new accessory (needs perms)'

      parameter name: :body, description: 'Accessory infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/accessoryProperties' } ],
                  required: %w[name image_path body_part]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/accessory'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(409, 'Accessory already exists') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/accessories/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get('show accessory') do
      tags 'Accessories'
      produces 'application/json'
      description 'Get infos on a specified accessory'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/accessory'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
    end

    patch('update accessory') do
      tags 'Accessories'
      produces 'application/json'
      consumes 'application/json'
      description 'Update infos of a specified accessory (needs perms)'

      parameter name: :body, description: 'Accessory infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/accessoryProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/accessory'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    put('update accessory') do
      tags 'Accessories'
      produces 'application/json'
      consumes 'application/json'
      description 'Update infos of a specified accessory (needs perms)'

      parameter name: :body, description: 'Accessory infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/accessoryProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/accessory'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    delete('delete accessory') do
      tags 'Accessories'
      description 'Delete a specified accessory (needs perms)'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not found') do run_test! end
    end
  end
end
