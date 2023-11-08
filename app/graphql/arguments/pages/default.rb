module Arguments
  module Pages
    module Default
      extend ActiveSupport::Concern

      included do
        argument :uuid,                 GraphQL::Schema::Mutation::ID, required: true
        argument :title,                String,                        required: false
        argument :title_font,           String,                        required: false
        argument :title_text_color,     String,                        required: false
        argument :image,                ApolloUploadServer::Upload,    required: false
        argument :tile_image,           ApolloUploadServer::Upload,    required: false
        argument :tile_image_alt_tag,   String,                        required: false
        argument :position,             Integer,                       required: false
        argument :parent_uuid,          GraphQL::Schema::Mutation::ID, required: false
        argument :content_version_uuid, GraphQL::Schema::Mutation::ID, required: false
      end
    end
  end
end
