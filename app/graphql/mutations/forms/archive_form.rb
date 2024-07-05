# app/graphql/mutations/forms/archive_form.rb
module Mutations
  module Forms
    class ArchiveForm < BaseMutation
      argument :uuid, ID, required: true

      type Types::FormType

      def resolve(uuid:)
        form = Form.find_by(uuid: uuid)
        form.archive!
        form
      end
    end
  end
end
