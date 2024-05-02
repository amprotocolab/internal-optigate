module Mutations
  module Contacts
    class CreateContact < BaseMutation
      argument :uuid,          ID,      required: true
      argument :first_name,    String,  required: true
      argument :last_name,     String,  required: true
      argument :email,         String,  required: true
      argument :contact_number,String,  required: true
      argument :message,       String, required: true

      field :contact, Types::ContactType, null: false

      def resolve(uuid:, first_name:, last_name:, email:, contact_number:, message:)
        contact = Contact.create!(
          uuid: uuid,  
          first_name: first_name,
          last_name: last_name,
          email: email,
          contact_number: contact_number,
          message: message
        )
  
        {
          contact: contact, 
          message: 'Contact Information has been processed successfully.'
        }
      end
    end
  end
end
