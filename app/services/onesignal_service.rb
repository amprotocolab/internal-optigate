class OnesignalService
  def initialize(app_id, api_key)
    @app_id = app_id
    @api_key = api_key
  end

  def send_notification(title, content, headings, included_segments)
    notification = OneSignal::Notification.new(
      app_id: @app_id,
      api_key: @api_key,
      contents: { en: content },
      headings: { en: headings[:en] }, 
      included_segments: included_segments
    )

    notification.create
  end
end
