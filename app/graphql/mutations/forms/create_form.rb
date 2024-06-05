module Mutations
  class CreateForm < BaseMutation
    argument :uuid, String, required: true
    argument :form_type, Types::FormTypeEnum, required: true
    argument :title, String, required: true
    argument :html_script, String, required: false
    argument :state, String, required: true

    type Types::FormType

    def resolve(uuid:, form_type:, title:, html_script:, state:)
      user = context[:current_user] 
      raise GraphQL::ExecutionError, "Authentication required" unless user

      form = user.forms.create!(
        uuid: uuid,
        form_type: form_type,
        title: title,
        html_script: html_script,
        state: state
      )
      form
    end
  end
end
