module Types
  class FormFieldType < Types::BaseObject
    field :uuid, ID, null: false
    field :field_type, FormFieldTypeEnum, null: false
    field :custom_css, String, null: false
    field :label, String, null: false
    field :font_type, String, null: false
    field :font_size, Integer, null: false
    field :font_family, String, null: false
    field :fill_color, String, null: false
    field :fill_color_percent, Integer, null: false
    field :alignment_type, AlignmentTypeEnum, null: false
  end
end
