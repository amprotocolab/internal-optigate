# app/graphql/types/form_field_input_type.rb
module Types
  class FormFieldInputType < Types::BaseInputObject
    graphql_name 'FormFieldInputType'

    argument :field_type, FieldTypeEnum, required: true
    argument :custom_css, String, required: true
    argument :label, String, required: true
    argument :font_type, String, required: true
    argument :font_size, Integer, required: true
    argument :font_family, String, required: true
    argument :fill_color, String, required: true
    argument :fill_color_percent, Integer, required: true
    argument :alignment_type, AlignmentTypeEnum, required: true
  end
end
