module Mutations
  module Forms
  class CreateFormWithAssociations < BaseMutation
    argument :form_attributes, Types::FormInput, required: true
    argument :form_fields_attributes, [Types::FormFieldInput], required: false
    argument :visitors_attributes, [Types::VisitorInput], required: false

    type Types::FormType

    def resolve(form_attributes:, form_fields_attributes: nil, visitors_attributes: nil)
      form = Form.create!(form_attributes.to_h)

      form_fields_attributes&.each do |form_field_attributes|
        form.form_fields.create!(form_field_attributes.to_h)
      end

      visitors_attributes&.each do |visitor_attributes|
        form.visitors.create!(visitor_attributes.to_h)
      end

      form
    end
  end
end
