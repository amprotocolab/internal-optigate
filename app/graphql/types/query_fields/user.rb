module Types
  module QueryFields
    module User
      extend ActiveSupport::Concern

      included do
        field(
          :users,
          resolver: Resolvers::Users::Index,
          guard:    ->(_, _, ctx) { ctx[:current_ability].can?(:index, User) }
        ) do
          extension(
            Extensions::SortExtension,
            sort_column_type:    Types::Users::UserSortColumnsEnumType,
            sort_column_default: :first_name
          )
        end
      end
    end
  end
end
