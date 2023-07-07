require 'swagger_helper'

RSpec.describe 'tasks', type: :request do

  path '/tasks' do

    get('list tasks') do
      tags 'Tasks'
      produces 'application/json'
      description 'List all tasks the user has access to'

      parameter name: 'date', in: :query, type: :string, description: 'Permit to ask for the tasks for a specific date',
                schema: { type: 'string', format: "date-time"}

      response(200, 'Successful') do
        schema type: 'array', items: { '$ref' => '#/components/schemas/task' }
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
    end

    post('create task') do
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'
      description 'Creates a task with the provided infos'

      parameter name: :body, description: 'Task infos', in: :body,
                schema: {
                  allOf: [ { '$ref' => '#/components/propertiesSchemas/taskProperties' } ],
                  required: %w[title description done]
                }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/task'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end

  path '/tasks/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'DB object id'

    get('show task') do
      tags 'Tasks'
      produces 'application/json'
      description 'Get the task with the provided id'

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/task'
        run_test!
      end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
    end

    delete('delete task') do
      tags 'Tasks'
      description 'Delete the task with the providede id'

      response(204, 'Deleted') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
    end

    patch('update task') do
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'
      description 'Update the task with the providede id'

      parameter name: :body, description: 'Task infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/taskProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/task'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end

    put('update task') do
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'
      description 'Update the task with the providede id'

      parameter name: :body, description: 'Task infos', in: :body,
                schema: { '$ref' => '#/components/propertiesSchemas/taskProperties' }

      response(200, 'Successful') do
        schema '$ref' => '#/components/schemas/task'
        run_test!
      end
      response(400, 'Bad request') do run_test! end
      response(401, 'Unauthorized') do run_test! end
      response(403, 'Forbidden') do run_test! end
      response(404, 'Not Found') do run_test! end
      response(422, 'Unprocessable Entity') do run_test! end
    end
  end
end
