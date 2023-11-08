class InternalOptigateSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  max_depth(20)
  default_max_page_size(300)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

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

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    # TODO: Implement this method
    # to return the correct GraphQL object type for `obj`
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object_id = object.to_global_id.to_s
    # Remove this redundant prefix to make IDs shorter:
    object_id = object_id.sub("gid://#{GlobalID.app}/", "")
    encoded_id = Base64.urlsafe_encode64(object_id)
    # Remove the "=" padding
    encoded_id = encoded_id.sub(/=+/, "")
    # Add a type hint
    type_hint = type_definition.graphql_name.first
    "#{type_hint}_#{encoded_id}"
  end

  # Given a string UUID, find the object
  def self.object_from_id(encoded_id_with_hint, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    # Split off the type hint
    _type_hint, encoded_id = encoded_id_with_hint.split("_", 2)
    # Decode the ID
    id = Base64.urlsafe_decode64(encoded_id)
    # Rebuild it for Rails then find the object:
    full_global_id = "gid://#{GlobalID.app}/#{id}"
    GlobalID::Locator.locate(full_global_id)
  end
end
