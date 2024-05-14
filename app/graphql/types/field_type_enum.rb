module Types
  class FieldTypeEnum < GraphQL::Schema::Enum
    value "button", value: 0
    value "checkbox", value: 1
  end
end
