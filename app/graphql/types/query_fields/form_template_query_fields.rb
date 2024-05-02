# app/graphql/types/query_fields/form_templates.rb
module Types
  module QueryFields
    module FormTemplateQueryFields
      extend ActiveSupport::Concern

      included do
        field(
          :form_templates,
          resolver: Resolvers::Forms::FormTemplates::Index,
          guard: ->(_, _, ctx) { ctx[:current_ability].can?(:index, FormTemplate) }
        )
      end
    end
  end
end
