module Types
  class MutationType < Types::BaseObject
    include MutationFields::Dashboard
    include MutationFields::AdsAccount
    include MutationFields::AgencyIntegration
    include MutationFields::Goal
    include MutationFields::Integration
    include MutationFields::Plan
    include MutationFields::Project
    include MutationFields::User
    include MutationFields::Contact
    include MutationFields::SystemNotificationMutationFields
  end
end
