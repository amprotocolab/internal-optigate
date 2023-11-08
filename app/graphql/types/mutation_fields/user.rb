module Types
  module MutationFields
    module User
      extend ActiveSupport::Concern

      included do
        field(
          :update_user,
          mutation: Mutations::Users::UpdateUser,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:update, :user) }
        )
      end
    end
  end
end
