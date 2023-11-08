module Types
  class MediumUploadedFileType < Types::UploadedFileType
    field :file_size, String, null: false
    field :file_name, String, null: false

    def file_size
      object.size
    end

    def file_name
      object.metadata['filename']
    end
  end
end
