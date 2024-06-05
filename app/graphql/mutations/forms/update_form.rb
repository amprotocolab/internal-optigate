module Mutations
  module Forms  
  class UpdateForm < BaseMutation
    argument :id, ID, required: true
    argument :form_type, Types::FormTypeEnum, required: false
    argument :title, String, required: false
    argument :html_script, String, required: false
    argument :state, String, required: false

    type Types::FormType

    def resolve(id:, form_type: nil, title: nil, html_script: nil, state: nil)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Authentication required" unless user

      form = user.forms.find_by(id: id)
      raise GraphQL::ExecutionError, "Form not found" unless form

      form.update!(
        form_type: form_type,
        title: title,
        html_script: html_script,
        state: state
      )

      form
    end
   end
  end
end
