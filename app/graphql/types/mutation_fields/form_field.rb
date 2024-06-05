module Types
  module MutationFields
      extend ActiveSupport::Concern

      included do
        field(
          :create_form_field,
          mutation: Mutations::CreateFormField,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:create, FormField) }
        )
    end
  end
end