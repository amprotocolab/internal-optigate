module Types
  class FormType < Types::BaseObject
    field :uuid, ID, null: false
    field :form_type, FormTypeEnum, null: false
    field :title, String, null: false
    field :html_script, String, null: true
    field :state, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
