module Types
  class MutationType < Types::BaseObject
    include MutationFields::User
    include MutationFields::Contact
    include MutationFields::SystemNotification
    include MutationFields::Form
    include MutationFields::FormField
  end
end
