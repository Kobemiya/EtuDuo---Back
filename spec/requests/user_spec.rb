require 'swagger_helper'

RSpec.describe 'user', type: :request do

  path '/user' do

    get('User infos') do
      tags 'User'
      produces 'application/json'
      description 'Fetch the user\'s informations stored in the DB'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/user'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('User creation') do
      tags 'User'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a user in DB to sync with Auth0 user'

      parameter name: :body, description: 'Create with user infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/userProperties' } ],
                  required: %w[username]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/user'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(409, 'User already exists') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    delete('User deletion') do
      tags 'User'
      description 'Delete the user in DB to desync with Auth0 user'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
    end

    put('User update') do
      tags 'User'
      consumes 'application/json'
      produces 'application/json'
      description 'Update the user\'s infos in DB'

      parameter name: :body, description: 'Update with user infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/userProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/user'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    patch('User update') do
      tags 'User'
      consumes 'application/json'
      produces 'application/json'
      description 'Update the user\'s infos in DB'

      parameter name: :body, description: 'Update with user infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/userProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/user'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end
end
