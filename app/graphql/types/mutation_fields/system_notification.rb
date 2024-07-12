module Types
  module MutationFields
    module SystemNotification
      extend ActiveSupport::Concern

      included do
        field(
          :create_system_notification,
          mutation: Mutations::SystemNotifications::CreateSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:create, SystemNotification) }
        )

        field(
          :update_system_notification,
          mutation: Mutations::SystemNotifications::UpdateSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )

        field(
          :delete_system_notification,
          mutation: Mutations::SystemNotifications::DeleteSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:delete, SystemNotification) }
        )

        field(
          :mark_system_notification_as_read,
          mutation: Mutations::SystemNotifications::MarkSystemNotificationAsRead,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )
      end
    end
  end
end
