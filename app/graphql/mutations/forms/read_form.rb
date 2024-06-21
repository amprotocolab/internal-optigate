module Mutations
  module Forms
    class ReadForm < BaseMutation
      argument :id, ID, required: true

      type Types::FormType

      def resolve(id:)
        Form.find(id)
      end
    end
  end
end
