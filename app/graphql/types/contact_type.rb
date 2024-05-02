module Types
  class ContactType < BaseObject
    field :uuid,           ID,          null: false
    field :first_name,     String,      null: false
    field :last_name,      String,      null: false
    field :email,          String,      null: false
    field :contact_number, String,      null: false
    field :message,        String,      null: false
    field :created_at,     IsoTimeType, null: false

    def admin
      object.admin?
    end

    def super_admin
      object.super_admin?
    end
  end
end
