# app/graphql/resolvers/system_notifications/show.rb
module Resolvers
  module SystemNotifications
    class Show < Base
      type Types::SystemNotificationType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        ::SystemNotifications::Finder.call(id)
      end
    end
  end
end
