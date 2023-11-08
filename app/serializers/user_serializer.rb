class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :first_name, :last_name, :email, :phone_number, :uid

  has_many :roles
end
