# app/graphql/types/form_type_enum.rb
module Types
  class FormTypeEnum < Types::BaseEnum
    value "MODAL", value: "modal"
    value "SLIDEIN", value: "slidein"
    value "INLINE", value: "inline"
    value "STICKYBAR", value: "stickybar"
  end
end
