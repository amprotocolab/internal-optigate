module Types
  class FormfieldType < BaseObject
    field :uuid, ID, null: false
    field :field_type, Types::FieldTypeEnum, null: false
    field :label, String, null: false
    field :font_type, String, null: false
    field :font_size, Int, null: false
    field :font_family, String, null: false
    field :fill_color, String, null: false
    field :fill_color_percent, String, null: false
    field :alignment_type, Types::AlignmentTypeEnum, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end