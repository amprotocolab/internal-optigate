module Types
  class FieldTypeEnum < GraphQL::Schema::Enum
    value "BUTTON", value: 0
    value "CHECKBOX", value: 1
  end
end
