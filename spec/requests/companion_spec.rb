require 'rails_helper'

RSpec.describe "Companions", type: :request do
  path '/companion' do

    get('show companion') do
      tags 'Companion'
      produces 'application/json'
      description 'List all companion\'s accessories and its caracteristics'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/companion'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    put('update companion') do
      tags 'Companion'
      consumes 'application/json'
      description 'Modify companion\'s attributes'

      parameter name: :body, description: 'Companion\'s appearance', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/companionProperties' }

      response(204, 'Created or Updated') do
        run_test!
      end
      response(400, 'Bad Request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(401, 'Forbidden') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end
end
