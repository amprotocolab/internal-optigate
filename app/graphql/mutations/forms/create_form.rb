module Mutations
  module Forms
    class CreateForm < BaseMutation
      argument :form_attributes, Types::FormInputType, required: true
      argument :form_fields_attributes, [Types::FormfieldInputType], required: false
      argument :visitors_attributes, [Types::VisitorInputType], required: false

      type Types::FormType

      def resolve(form_attributes:, form_fields_attributes: nil, visitors_attributes: nil)
        ActiveRecord::Base.transaction do
          save_as_template = form_attributes.delete(:save_as_template) || false

          form = if save_as_template
                   FormTemplate.create!(form_attributes.to_h)
                 else
                   Form.create!(form_attributes.to_h)
                 end

          create_related_entities(form, form_fields_attributes, visitors_attributes)

          form
        end
      rescue ActiveRecord::RecordInvalid => e
        raise GraphQL::ExecutionError, "Validation failed: #{e.record.errors.full_messages.join(', ')}"
      end

      private

      def create_related_entities(form, form_fields_attributes, visitors_attributes)
        form_fields_attributes&.each do |attrs|
          form.form_fields.create!(attrs.to_h)
        end
        visitors_attributes&.each do |attrs|
          form.visitors.create!(attrs.to_h)
        end
      end
    end
  end
end
