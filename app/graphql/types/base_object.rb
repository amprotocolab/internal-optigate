module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    def current_user
      context[:current_user]
    end

    def has_access
      return true if current_user.administrator?

      content_version =
        if object.class == ContentVersion
          object
        elsif object.class == Page
          object.content_version
        end

      StoreContentVersionUpdate.filtered_content_version_ids(current_user.store_ids).include? content_version.id
    end
  end
end
