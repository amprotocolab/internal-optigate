# app/graphql/resolvers/forms/index.rb
module Resolvers
  module Forms
    class Index < Base
      type [Types::FormInputType], null: true

      def resolve
        Form.all
      end
    end
  end
end
