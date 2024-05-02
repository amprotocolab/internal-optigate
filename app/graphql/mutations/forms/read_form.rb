module Mutations
  module Forms
    class ReadForm < BaseMutation
      argument :id, ID, required: true

      type Types::FormInputType

      def resolve(id:)
        Form.find(id)
      end
    end
  end
end
