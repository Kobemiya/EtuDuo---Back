require 'rails_helper'

RSpec.describe "Stats", type: :request do

  path('/stats') do
    get('List stats') do
      tags 'Stats'
      produces 'application/json'
      description 'List all stats of a user'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/stat'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end
  end

end
