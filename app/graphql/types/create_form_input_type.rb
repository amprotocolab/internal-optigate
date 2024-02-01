module Types
  class FormInput < BaseInputObject
    argument :uuid, ID, required: false
    argument :form_type, String, required: true
    argument :title, String, required: true
    argument :custom_css, String, required: false
    argument :html_script, String, required: false
  end
end
