class Onesignalservice
  def initialize(app_id, app_auth_key)
    @app_id = app_id
    @app_auth_key = app_auth_key
  end

  def send_notification(title, content, state, headers)
    notification = OneSignal::Notification.new(
      app_id: @app_id,
      contents: { en: content },
      headings: { en: title }, 
      included_segments: ['All'], 
      data: { state: state } 
    )
    api_instance = OneSignal::DefaultApi.new

    headers.each { |key, value| api_instance.api_client.default_headers[key] = value }
    
    begin
      response = api_instance.create_notification(notification)
      p response 
    rescue OneSignal::ApiError => e
      puts "Error when calling DefaultApi->create_notification: #{e}"
    end
  end
end