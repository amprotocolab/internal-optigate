module Types
  module QueryFields
    module FormQueryFields
      extend ActiveSupport::Concern

      included do
        field(
          :form,
          resolver: Resolvers::Forms::Show,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:read, Form) }
        ) do
          argument :id, GraphQL::Types::ID, required: true 
        end

        field(
          :forms,
          resolver: Resolvers::Forms::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, Form) }
        )
      end
    end
  end
end
