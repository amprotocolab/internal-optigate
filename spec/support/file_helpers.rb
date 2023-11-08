module FileHelpers
  def check_qr(qr)
    if ENV['IROBOT_CHECK_QR_COMMAND'].present?
      Rails.logger.info "Opening: #{qr.path}"
      `#{ENV['IROBOT_CHECK_QR_COMMAND']} #{qr.path}`
    end
  end
end
