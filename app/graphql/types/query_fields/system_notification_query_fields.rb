# app/graphql/types/query_fields/system_notification_query_fields.rb
module Types
  module QueryFields
    module SystemNotificationQueryFields
      extend ActiveSupport::Concern

      included do

                                     #List

        field(
          :system_notifications,
          resolver: Resolvers::SystemNotifications::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, SystemNotification) }
        ) do
          extension(
            Extensions::SortExtension,
            sort_column_type:    Types::SystemNotifications::SystemNotificationSortColumnsEnumType,
            sort_column_default: :created_at
          )
        end

                                   #read

        field(
          :system_notification,
          resolver: Resolvers::SystemNotifications::Show,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:show, SystemNotification) }
        ) do
          argument :id, ID, required: true
        end
      end
    end
  end
end
