module Mutations
  module Forms
    class UpdateForm < BaseMutation
      argument :id, ID, required: true
      argument :form_type, String, required: false
      argument :title, String, required: false
      argument :custom_css, String, required: false
      argument :html_script, String, required: false

      type Types::FormInputType

      def resolve(id:, form_type: nil, title: nil, custom_css: nil, html_script: nil)
        form = Form.find(id)
        form.update!(
          form_type: form_type,
          title: title,
          custom_css: custom_css,
          html_script: html_script
        )
        form
      end
    end
  end
end
