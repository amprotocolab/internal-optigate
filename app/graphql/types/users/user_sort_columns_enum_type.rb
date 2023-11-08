module Types
  module Users
    class UserSortColumnsEnumType < BaseSortColumnsEnumType
      value 'FIRST_NAME', value: :first_name
      value 'LAST_NAME',  value: :last_name
      value 'EMAIL',      value: :email
    end
  end
end
