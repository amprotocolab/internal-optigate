module Types
  class RoleType < Types::BaseObject
    field :uuid, ID,     null: false
    field :name, String, null: false
  end
end
