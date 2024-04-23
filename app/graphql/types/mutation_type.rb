module Types
  class MutationType < Types::BaseObject
    include MutationFields::User
    include MutationFields::Contact
    include MutationFields::SystemNotificationMutationFields
    include MutationFields::Forms
  end
end
