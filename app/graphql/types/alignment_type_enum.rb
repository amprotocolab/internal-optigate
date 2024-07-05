module Types
  class AlignmentTypeEnum < GraphQL::Schema::Enum
    value "left", value: 0
    value "center", value: 1
    value "right", value: 2
  end
end
