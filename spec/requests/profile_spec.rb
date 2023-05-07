require 'swagger_helper'

RSpec.describe 'profile', type: :request do

  path '/profile' do

    get('Show profile') do
      tags 'Profile'
      description 'Show user\'s current profile informations'
      produces 'application/json'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/profile'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    put('Update profile') do
      tags 'Profile'
      description 'Update or create the user\'s profile'
      consumes 'application/json'

      parameter name: :body, description: 'Profile infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/profileProperties' } ],
                  required: %w[occupation prod_period start_work end_work]
                }

      response(204, 'Created or Updated') do
        schema '$ref' => '#/components/propertiesSchemas/'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end
end
