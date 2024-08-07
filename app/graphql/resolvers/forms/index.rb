# app/graphql/resolvers/forms/index.rb
module Resolvers
  module Forms
    class Index < Base
      type [Types::FormType.connection_type], null: false

      argument :first, Integer, required: false
      argument :after, String, required: false
      argument :last, Integer, required: false
      argument :before, String, required: false 

      def resolve(**args)
        Form.all
      end
    end
  end
end
