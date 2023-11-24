module Types
  module MutationFields
    module Contact
      extend ActiveSupport::Concern

      included do
        field(
          :create_contact,
          mutation: Mutations::Contacts::CreateContact,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:create, :contact) }
        )
      end
    end
  end
end
