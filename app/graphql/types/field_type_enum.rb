# app/graphql/types/field_type_enum.rb
module Types
  class FieldTypeEnum < Types::BaseEnum
    value "BUTTON", value: "button"
    value "CHECKBOX", value: "checkbox"
  end
end
