module Mutations
  class BaseDeleteMutation < BaseMutation
    argument :uuid, ID, required: true

    field :success, Boolean, null: false

    def resolve(uuid:)
      record_to_delete = record(uuid)
      callback.call(record_to_delete) if callback?

      if record_to_delete.destroy
        { success: true }
      else
        entity_errors(record_to_delete)

        { success: false }
      end
    end

    private

    def record(uuid)
      entity.find_by!(uuid: uuid)
    end

    def callback?
      respond_to?(:callback, true)
    end
  end
end
