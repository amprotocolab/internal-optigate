# app/graphql/types/mutation_fields/forms.rb
module Types
  module MutationFields
    module Forms
      extend ActiveSupport::Concern

      included do
        field(
          :create_form,
          mutation: Mutations::CreateFormWithAssociations,
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
      end
    end
  end
end
