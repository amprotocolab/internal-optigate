module Arguments
  module Pages
    module DescriptionPage
      extend ActiveSupport::Concern

      included do
        argument :icon_image,                  ApolloUploadServer::Upload, required: false
        argument :icon_image_alt_tag,          String,                     required: false
        argument :navigation_bar_button_color, String,                     required: false
        argument :accent_color,                String,                     required: false
        argument :background_color,            String,                     required: false
        argument :button_background_color,     String,                     required: false
        argument :button_icon_color,           String,                     required: false
        argument :back_button_icon_color,      String,                     required: false
      end
    end
  end
end
