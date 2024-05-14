module Types
  class FormfieldInputType < Types::BaseInputObject
    argument :uuid, ID, required: false
    argument :field_type, Types::FieldTypeEnum, required: true
    argument :label, String, required: true
    argument :font_type, String, required: true
    argument :font_size, Int, required: true
    argument :font_family, String, required: true
    argument :fill_color, String, required: true
    argument :fill_color_percent, String, required: true
    argument :alignment_type, Types::AlignmentTypeEnum, required: true
  end
end
