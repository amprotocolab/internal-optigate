def fixture_file_upload(file_name)
  Rack::Test::UploadedFile.new(file_name, nil)
end
