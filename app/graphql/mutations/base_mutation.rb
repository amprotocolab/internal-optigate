module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    private

    def errors_for_array(errors)
      errors.each do |error|
        context.add_error(graphql_error(error))
      end
    end

    def entity_errors(entity)
      entity.errors.full_messages.each do |message|
        context.add_error(graphql_error(message))
      end

      nil
    end

    def service_errors(service)
      service.errors.each do |message|
        context.add_error(graphql_error(message))
      end

      nil
    end

    def result_errors(result)
      context.add_error(graphql_error(result.failure))

      nil
    end

    def graphql_error(message, opts = {})
      GraphQL::ExecutionError.new(message, options: opts)
    end

    def current_user
      context[:current_user]
    end
  end
end
