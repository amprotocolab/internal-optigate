module Resolvers
  module SystemNotifications
    class Index < Base
      type Types::SystemNotificationType.connection_type, null: false

      argument :query, String, required: false

      def resolve(**attrs)
        ::SystemNotifications::Searcher.call(attrs)
      end
    end
  end
end
