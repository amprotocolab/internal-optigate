module Types
  module MutationFields
    module SystemNotification
      extend ActiveSupport::Concern

      included do
        field(
          :create_system_notifications,
          mutation: Mutations::SystemNotifications::CreateSystemNotifications,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:create, SystemNotification) }
        )

        field(
          :update_system_notifications,
          mutation: Mutations::SystemNotifications::UpdateSystemNotifications,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )

        field(
          :delete_system_notifications,
          mutation: Mutations::SystemNotifications::DeleteSystemNotifications,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:delete, SystemNotification) }
        )

        field(
          :mark_system_notifications_as_read,
          mutation: Mutations::SystemNotifications::MarkSystemNotificationsAsRead,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )
      end
    end
  end
end
