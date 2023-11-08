class UserLoginSerializer < ActiveModel::Serializer
  attributes :uuid, :first_name, :last_name, :email

  has_many :roles
end
