module Types
  module MutationFields
    module Form
      extend ActiveSupport::Concern

      included do
        field(
          :create_form,
          mutation: Mutations::Forms::CreateForm,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:create, Form) }
        )

        field(
          :update_form,
          mutation: Mutations::Forms::UpdateForm,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:update, Form) }
        )

        field(
          :archive_form,
          mutation: Mutations::Forms::ArchiveForm,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:archive, Form) }
        )

        field(
          :duplicate_form_template,
          mutation: Mutations::Forms::DuplicateFormTemplate,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:duplicate, FormTemplate) }
        )
      end
    end
  end
end
