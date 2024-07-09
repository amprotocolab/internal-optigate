module Mutations
  module Forms  
    class UpdateForm < BaseMutation
      argument :uuid, ID, required: true
      argument :form_type, Types::FormTypeEnum, required: false
      argument :title, String, required: false
      argument :html_script, String, required: false
      argument :state, String, required: false
      argument :email_confirmation_with_otp, Boolean, required: false
      argument :thank_you_message, Boolean, required: false
      argument :form_fields_attributes, [Types::FormFieldInputType], required: false

      type Types::FormType

      def resolve(uuid:, form_type: nil, title: nil, html_script: nil, state: nil, email_confirmation_with_otp: nil, thank_you_message: nil, form_fields_attributes: [])
        user = context[:current_user]
        raise GraphQL::ExecutionError, "Authentication required" unless user

        form = user.forms.find_by(uuid: uuid)
        raise GraphQL::ExecutionError, "Form not found" unless form

        form_params = {
          form_type: form_type,
          title: title,
          html_script: html_script,
          state: state,
          email_confirmation_with_otp: email_confirmation_with_otp,
          thank_you_message: thank_you_message,
          form_fields_attributes: form_fields_attributes.map(&:to_h)
        }.compact

        form.update!(form_params)

        form
      end
    end
  end
end
