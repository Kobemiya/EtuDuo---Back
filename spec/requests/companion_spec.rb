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

    path '/companion/{accessory_id}' do
      parameter name: 'accessory_id', in: :path, type: :string, description: 'accessory_id'

      put('Equip accessory') do
        tags 'Companion'
        description 'Add accessory on companion'

        response(204, 'Equipped') do run_test! end
        response(401, 'Unauthorized') do run_test! end
        response(403, 'Forbidden') do run_test! end
        response(404, 'Not found') do run_test! end
        response(409, 'Conflict') do run_test! end
      end

      delete('Unequip accessory') do
        tags 'Companion'
        description 'Remove accessory from companion'

        response(204, 'Unequipped') do run_test! end
        response(401, 'Unauthorized') do run_test! end
        response(404, 'Not found') do run_test! end
        response(409, 'Conflict') do run_test! end
      end
    end
  end
end
