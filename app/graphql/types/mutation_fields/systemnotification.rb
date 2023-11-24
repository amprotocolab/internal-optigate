# app/graphql/types/mutation_fields/system_notification_mutation_fields.rb
module Types
  module MutationFields
    module SystemNotificationMutationFields
      extend ActiveSupport::Concern

      included do
        field(
          :create_system_notification,
          mutation: Mutations::CreateSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:create, SystemNotification) }
        )

        field(
          :update_system_notification,
          mutation: Mutations::UpdateSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )

        field(
          :delete_system_notification,
          mutation: Mutations::DeleteSystemNotification,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:delete, SystemNotification) }
        )

        field(
          :mark_system_notifications_as_read,
          mutation: Mutations::MarkSystemNotificationsAsRead,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:update, SystemNotification) }
        )
      end
    end
  end
end
