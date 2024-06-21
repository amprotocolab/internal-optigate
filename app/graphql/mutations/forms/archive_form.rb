# app/graphql/mutations/forms/archive_form.rb
module Mutations
  module Forms
    class ArchiveForm < BaseMutation
      argument :id, ID, required: true

      type Types::FormType

      def resolve(id:)
        form = Form.find(id)
        form.archive!
        form
      end
    end
  end
end
