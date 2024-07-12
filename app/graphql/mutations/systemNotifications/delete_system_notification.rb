module Mutations
  module SystemNotifications
    class DeleteSystemNotification < BaseMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        system_notification = SystemNotification.find_by(id: id)

        if system_notification&.destroy
          { success: true }
        else
          { success: false }
        end
      end
    end
  end
end