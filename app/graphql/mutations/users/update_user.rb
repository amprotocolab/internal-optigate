module Mutations
  module Users
    class UpdateUser < BaseMutation
      argument :uuid,         ID,      required: true
      argument :first_name,   String,  required: false
      argument :last_name,    String,  required: false
      argument :phone_number, String,  required: false

      field :user, Types::UserType, null: false

      def resolve(uuid:, **attrs)
        user = User.find_by(uuid: uuid)

        if user.update(attrs)
          { user: user }
        else
          entity_errors(user)
        end
      end
    end
  end
end
