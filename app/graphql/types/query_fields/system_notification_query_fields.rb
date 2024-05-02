module Types
  module QueryFields
    module SystemNotificationQueryFields
      extend ActiveSupport::Concern

      included do
        # List
        field(
          :system_notifications,
          resolver: Resolvers::SystemNotifications::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, SystemNotification) }
        )
        # Read
        field(
          :system_notification,
          resolver: Resolvers::SystemNotifications::Show,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:show, SystemNotification) }
        )
        # ) do
        #   argument :id, ID, required: true
        # end
      end
    end
  end
end
