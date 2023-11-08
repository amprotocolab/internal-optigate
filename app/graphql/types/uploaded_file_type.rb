module Types
  class UploadedFileType < BaseObject
    field :url,          String, null: false
    field :content_type, String, null: false
  end
end
