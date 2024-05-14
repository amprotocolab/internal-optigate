module Types
  class FormType < BaseObject
    field :uuid, ID, null: false
    field :form_type, Types::FormTypeEnum, null: false
    field :title, String, null: false
    field :custom_css, String, null: true
    field :html_script, String, null: true
    field :form_fields, [Types::FormfieldType], null: true
    field :visitors, [Types::VisitorType], null: true
    field :state, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
