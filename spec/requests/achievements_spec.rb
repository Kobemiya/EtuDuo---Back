require 'rails_helper'

RSpec.describe "achievements", type: :request do
  path '/achievements' do
    
    get('list achievements') do
      tags 'Achievements'
      produces 'application/json'
      description 'List all achievements in the game'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/achievement' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('create achievement') do
      tags 'Achievements'
      produces 'application/json'
      consumes 'application/json'
      description 'Create a new achievement'

      parameter name: :body, description: 'Achievement infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/achievementProperties' } ],
                  required: %w[image_path]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/achievement'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/achievements/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get('show achievement') do
      tags 'Achievements'
      produces 'application/json'
      description 'Get infos on a specified achievement'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/achievement'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
    end

    patch('update achievement') do
      tags 'Achievements'
      produces 'application/json'
      consumes 'application/json'
      description 'Update infos of a specified achievement'

      parameter name: :body, description: 'Achievement infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/achievementProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/achievement'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    put('update achievement') do
      tags 'Achievements'
      produces 'application/json'
      consumes 'application/json'
      description 'Update infos of a specified achievement'

      parameter name: :body, description: 'Achievement infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/achievementProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/achievement'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    delete('delete achievement') do
      tags 'Achievements'
      description 'Delete a specified achievement'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
    end
  end


  path '/achievements/{achievement_id}/grant' do
    parameter name: 'achievement_id', in: :path, type: :integer, description: 'id'

    put('grant achievement') do
      tags 'Achievements'
      produces 'application/json'
      description 'Grant the specified achievement to the user'

      response(204, 'Successful') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    post('grant achievement') do
      tags 'Achievements'
      produces 'application/json'
      description 'Grant the specified achievement to the user'

      response(204, 'Successful') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(404, 'Not found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/user/achievements' do
    get('list user\'s achievements') do
      tags 'Achievements'
      produces 'application/json'
      description 'List all achievements obtained by the user'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/achievement' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end
  end
end
