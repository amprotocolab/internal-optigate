module Mutations
  module Forms
    class ReadForm < BaseMutation
      argument :uuid, ID, required: true

      type Types::FormType

      def resolve(uuid:)
        Form.find_by(uuid: uuid)
      end
    end
  end
end
