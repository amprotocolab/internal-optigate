  module Types
    class VisitorType < BaseObject
      field :uuid, ID, null: false
      field :title, String, null: false
      field :email, String, null: false
      field :phone_number, String, null: false
      field :company, String, null: false
      field :otp_code, String, null: false
      field :subscriber, Boolean, null: false
      field :paying, Boolean, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
