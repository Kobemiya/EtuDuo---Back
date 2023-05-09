require 'swagger_helper'

RSpec.describe 'tags', type: :request do

  path '/tasks/tags' do

    get('List tags') do
      tags 'Tasks tags'
      produces 'application/json'
      description 'List all user\'s task tags'

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/tag' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('Create tag') do
      tags 'Tasks tags'
      consumes 'application/json'
      produces 'application/json'
      description 'Create a tag for the tasks'

      parameter name: :body, description: 'Tag infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/tagProperties' } ],
                  required: %w[name color]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/tag'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/tasks/tags/{id}' do

    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show tag') do
      tags 'Tasks tags'
      produces 'application/json'
      description 'Show a specifid tag infos'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/tag'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
    end

    patch('Update tag') do
      tags 'Tasks tags'
      consumes 'application/json'
      produces 'application/json'
      description 'Update a tag\'s infos'

      parameter name: :body, description: 'Tag infos', in: :body,
                schema: {'$ref' => '#/components/propertiesSchemas/tagProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/tag'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    put('Update tag') do
      tags 'Tasks tags'
      consumes 'application/json'
      produces 'application/json'
      description 'Update a tag\'s infos'

      parameter name: :body, description: 'Tag infos', in: :body,
                schema: {'$ref' => '#/components/propertiesSchemas/tagProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/tag'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    delete('Delete tag') do
      tags 'Tasks tags'
      description 'Delete the tag with the provided id'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
    end
  end
end
