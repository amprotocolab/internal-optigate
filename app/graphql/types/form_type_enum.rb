module Types
  class FormTypeEnum < GraphQL::Schema::Enum
    value "modal", value: 0
    value "slidein", value: 1
    value "inline", value: 2
    value "stickybar", value: 3
  end
end
