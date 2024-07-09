module Mutations
  module Forms
    class ReadForm < BaseMutation
      argument :uuid, ID, required: true

      type Types::FormType

      def resolve(uuid:)
        Form.find_by(uuid: uuid)
        raise GraphQL::ExecutionError, "Form not found" unless form
        form
      end
    end
  end
end
