# app/graphql/types/alignment_type_enum.rb
module Types
  class AlignmentTypeEnum < Types::BaseEnum
    value "LEFT", value: "left"
    value "CENTER", value: "center"
    value "RIGHT", value: "right"
  end
end
