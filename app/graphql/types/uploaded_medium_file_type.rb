module Types
  class UploadedMediumFileType < BaseObject
    field :thumbnail, Types::MediumUploadedFileType, null: false
    field :original,  Types::MediumUploadedFileType, null: false

    def thumbnail
      object[:thumbnail]
    end

    def original
      object[:original]
    end
  end
end
