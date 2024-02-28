# app/graphql/types/form_template_type.rb
module Types
  class FormTemplateType < Types::BaseObject
    field :prebuilt_template, Boolean, null: false
    field :custom_saved_template, Boolean, null: false
  end
end
