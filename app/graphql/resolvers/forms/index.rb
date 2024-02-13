# app/graphql/resolvers/forms/index.rb
module Resolvers
  module Forms
    class Index < Base
      type [Types::FormType], null: true

      def resolve
        Form.all
      end
    end
  end
end
