module Resolvers
  class Base < GraphQL::Schema::Resolver
    def current_user
      context[:current_user]
    end

    def extract_date_range(attrs)
      return if attrs[:start_date].nil?

      attrs[:end_date] = Time.zone.now if attrs[:end_date].nil?
      attrs[:start_date]..attrs[:end_date]
    end
  end
end
