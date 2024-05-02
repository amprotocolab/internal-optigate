class OptigateAPISchema < GraphQL::Schema
    mutation(Types::MutationType)
    query(Types::QueryType)

    max_depth(20)
    default_max_page_size(300)

    use GraphQL::Guard.new(
      not_authorized: ->(type, field) { GraphQL::ExecutionError.new("Not authorized to access #{type}.#{field}") }
    )

    rescue_from ActiveRecord::RecordNotFound do |exception|
      GraphQL::ExecutionError.new("Could not find #{exception.model}")
    end

    # Necessary as ActiveRecord won't validate uniqueness for nested attributes with scope
    # https://github.com/rails/rails/issues/20676
    rescue_from ActiveRecord::RecordNotUnique do |_|
      GraphQL::ExecutionError.new('Record violates a unique constraint, property already taken')
    end

    rescue_from ActiveRecord::RecordNotDestroyed do |exception|
      record = exception.record

      GraphQL::ExecutionError.new(
        "Cannot delete #{record.class.name} with UUID: #{record.uuid}. Errors: #{record.errors.full_messages}"
      )
    end
end