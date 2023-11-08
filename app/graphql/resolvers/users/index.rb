module Resolvers
  module Users
    class Index < Base
      type Types::UserType.connection_type, null: false

      argument :query, String, required: false

      def resolve(**attrs)
        ::Users::Searcher.call(attrs)
      end
    end
  end
end
