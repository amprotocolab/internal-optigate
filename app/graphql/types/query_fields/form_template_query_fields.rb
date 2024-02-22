# app/graphql/types/query_fields/form_templates.rb
module Types
  module QueryFields
    module FormTemplates
      extend ActiveSupport::Concern

      included do
        field(
          :form_templates,
          resolver: Resolvers::FormTemplates::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, FormTemplate) }
        )
      end
    end
  end
end
