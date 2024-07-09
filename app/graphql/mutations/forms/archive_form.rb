# app/graphql/mutations/forms/archive_form.rb
module Mutations
  module Forms
    class ArchiveForm < BaseMutation
      argument :uuid, ID, required: true

      type Types::FormType

      def resolve(uuid:)
        form = Form.find_by(uuid: uuid)
        raise GraphQL::ExecutionError, "Form not found" unless form
        form.archive!
        form
      end
    end
  end
end
