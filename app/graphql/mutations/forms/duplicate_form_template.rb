# app/graphql/mutations/forms/duplicate_form_template.rb
module Mutations
  module Forms
    class DuplicateFormTemplate < BaseMutation
      argument :form_template_id, ID, required: true

      type Types::FormInputType

      def resolve(form_template_id:)
        form_template = FormTemplate.find(form_template_id)

        # Create a new Form using the attributes of the FormTemplate
        form_attributes = form_template.attributes.except("id", "created_at", "updated_at")
        new_form = Form.create!(form_attributes)

        # Optionally, you can also duplicate associated form fields here if needed
        form_template.form_fields.each do |form_field|
          new_form.form_fields.create!(
            field_type: form_field.field_type,
            label: form_field.label,
            font_type: form_field.font_type,
            font_size: form_field.font_size,
            font_family: form_field.font_family,
            fill_color: form_field.fill_color,
            fill_color_percent: form_field.fill_color_percent,
            alignment_type: form_field.alignment_type
          )
        end

        new_form
      end
    end
  end
end
