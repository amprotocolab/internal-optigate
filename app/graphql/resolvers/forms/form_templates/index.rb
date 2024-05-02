# app/graphql/resolvers/forms/form_templates/index.rb
module Resolvers
    module Forms
    module FormTemplates
      class Index < Base
        type [Types::FormTemplateType], null: false

        def resolve
          FormTemplate.all
        end
      end
    end
  end
end