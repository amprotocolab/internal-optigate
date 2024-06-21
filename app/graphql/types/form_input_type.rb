module Types
  class FormInputType < Types::BaseInputObject
    argument :uuid, ID, required: false
    argument :form_type, Types::FormTypeEnum, required: true 
    argument :title, String, required: true
    argument :custom_css, String, required: false
    argument :html_script, String, required: false
  end
end
