# app/graphql/types/form_type.rb
module Types
  class FormType < Types::BaseObject
    field :uuid, ID, null: false
    field :form_type, Types::FormTypeEnum, null: false
    field :title, String, null: false
    field :html_script, String, null: true
    field :state, String, null: false
    field :email_confirmation_with_otp, Boolean, null: false
    field :thank_you_message, Boolean, null: false
    field :form_fields, [Types::FormFieldType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
