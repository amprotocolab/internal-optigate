module Resolvers
  class BaseShow < Base
    argument :uuid, ID, required: true

    def resolve(uuid:)
      entity.find_by!(uuid: uuid)
    end

    private

    def entity_error(message)
      context.add_error(graphql_error(message))

      nil
    end

    def graphql_error(message, opts = {})
      GraphQL::ExecutionError.new(message, options: opts)
    end
  end
end
