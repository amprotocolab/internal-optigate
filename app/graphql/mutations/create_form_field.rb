module Mutations
  class CreateFormField < BaseMutation
    argument :uuid, ID, required: true
    argument :field_type, Types::FormFieldTypeEnum, required: true
    argument :custom_css, String, required: true
    argument :label, String, required: true
    argument :font_type, String, required: true
    argument :font_size, Integer, required: true
    argument :font_family, String, required: true
    argument :fill_color, String, required: true
    argument :fill_color_percent, Integer, required: true
    argument :alignment_type, Types::AlignmentTypeEnum, required: true

    type Types::FormFieldType

    def resolve(uuid:, field_type:, custom_css:, label:, font_type:, font_size:, font_family:, fill_color:, fill_color_percent:, alignment_type:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user

      form_field = user.form_fields.create!(
        uuid: uuid,
        field_type: field_type,
        custom_css: custom_css,
        label: label,
        font_type: font_type,
        font_size: font_size,
        font_family: font_family,
        fill_color: fill_color,
        fill_color_percent: fill_color_percent,
        alignment_type: alignment_type
      )
      form_field
    end
  end
end
