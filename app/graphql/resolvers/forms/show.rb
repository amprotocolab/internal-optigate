# app/graphql/resolvers/forms/show.rb
module Resolvers
  module Forms
    class Show < Base
      type Types::FormType, null: true

      argument :uuid, ID, required: true

      def resolve(uuid:)
        Form.find_by(uuid: uuid)
      end
    end
  end
end
