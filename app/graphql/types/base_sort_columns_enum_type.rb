module Types
  class BaseSortColumnsEnumType < BaseEnum
    value 'ID',         value: :id
    value 'CREATED_AT', value: :created_at
    value 'UPDATED_AT', value: :updated_at
  end
end
