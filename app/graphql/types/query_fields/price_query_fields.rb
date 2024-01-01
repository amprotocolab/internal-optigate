module Types
  module QueryFields
    module PriceQueryFields
      extend ActiveSupport::Concern

      included do
        # List
        field(
          :prices,
          resolver: Resolvers::Prices::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, Price) }
        ) 
        # do
          # extension(
          #   Extensions::SortExtension,
          #   sort_column_type: Types::Prices::PriceSortColumnsEnumType,
          #   sort_column_default: :created_at
          # )
        # end
      end
    end
  end
end
