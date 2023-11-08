module Types
  class UserType < BaseObject
    field :uuid,         ID,          null: false
    field :first_name,   String,      null: false
    field :last_name,    String,      null: false
    field :full_name,    String,      null: false
    field :phone_number, String,      null: true
    field :email,        String,      null: false
    field :created_at,   IsoTimeType, null: false
    field :projects,     Types::ProjectType.connection_type, null: true do
      extension(
        Extensions::SortExtension,
        sort_column_default: :created_at,
        sort_column_type:    Types::Projects::ProjectSortColumnsEnumType
      )
    end
  end

  def admin
    object.admin?
  end

  def super_admin
    object.super_admin?
  end
end
