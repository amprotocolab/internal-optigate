# app/graphql/mutations/forms/create_form.rb
module Mutations
  module Forms
    class CreateForm < BaseMutation
      argument :form_type, Types::FormTypeEnum, required: true
      argument :title, String, required: true
      argument :html_script, String, required: false
      argument :state, String, required: true
      argument :email_confirmation_with_otp, Boolean, required: false
      argument :thank_you_message, Boolean, required: false
      argument :form_fields_attributes, [Types::FormFieldInputType], required: false

      type Types::FormType

      def resolve( form_type:, title:, html_script:, state:, email_confirmation_with_otp: false, thank_you_message: false, form_fields_attributes: [])
        user = context[:current_user]
        raise GraphQL::ExecutionError, "Authentication required" unless user

        form_params = {
          form_type: form_type,
          title: title,
          html_script: html_script,
          state: state,
          email_confirmation_with_otp: email_confirmation_with_otp,
          thank_you_message: thank_you_message,
          form_fields_attributes: form_fields_attributes.map(&:to_h)
        }

        form = user.forms.create!(form_params)
        form
      end
    end
  end
end
