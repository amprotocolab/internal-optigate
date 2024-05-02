module Types
  module QueryFields
    module PriceQueryFields
      extend ActiveSupport::Concern

      included do
        field(
          :prices,
          [Types::PriceType],
          null: false,
          description: "List of prices",
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, Price) }
        )

        field(
          :price,
          Types::PriceType,
          null: true,
          description: "Find a price by ID",
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:show, Price) }
        ) do
          argument :id, GraphQL::Types::ID, required: true 
       end
      end
    end
  end
end
