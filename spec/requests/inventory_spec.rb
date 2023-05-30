require 'swagger_helper'

RSpec.describe 'inventory', type: :request do

  path '/inventory' do

    get('Show inventory') do
      tags 'Inventory'
      produces 'application/json'
      description 'Display the user\'s inventory, which contains the accessories obtained'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/accessory' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end
  end

  path '/inventory/{accessory_id}' do
    parameter name: 'accessory_id', in: :path, type: :string, description: 'accessory_id'

    put('Add accessory in inventory') do
      tags 'Inventory'
      description 'Add a specified accessory in the user\'s inventory'

      response(204, 'Added') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(409, 'Conflict') do run_test! end
    end

    delete('Remove accessory from inventory') do
      tags 'Inventory'
      description 'Remove a specified accessory from the user\'s inventory'

      response(204, 'Removed') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(409, 'Conflict') do run_test! end
      response(422, 'Failed to update companion') do run_test! end
    end
  end
end
