module Mutations
  module Forms
    class CreateForm < BaseMutation
      argument :form_attributes, Types::FormInputType, required: true
      argument :form_fields_attributes, [Types::FormfieldInputType], required: false
      argument :visitors_attributes, [Types::VisitorInputType], required: false

      type Types::FormInputType

      def resolve(form_attributes:, form_fields_attributes: nil, visitors_attributes: nil)
        save_as_template = form_attributes.delete(:save_as_template) || false

        if save_as_template
          form = FormTemplate.create!(form_attributes.to_h)
        else
          form = Form.create!(form_attributes.to_h)
        end

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
end