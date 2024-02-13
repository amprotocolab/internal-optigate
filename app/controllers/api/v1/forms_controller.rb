# app/controllers/api/v1/forms_controller.rb
module API
  module V1
    class FormsController < ApplicationController
      def generate_otp
        form_uuid = params[:form_uuid]
        form_fields = params[:form_fields]

        form_otp_service = FormOtpService.new(form_uuid, form_fields)

        begin
          response = form_otp_service.generate_otp_and_send
          render json: { message: 'OTP Request Generated to Phone Number', data: response }, status: :ok
        rescue MissingMandatoryFieldsError => e
          render json: { error: 'Mandatory field values missing', fields: e.missing_fields }, status: :unprocessable_entity
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Invalid Form UUID provided' }, status: :not_found
        end
      end

      def verify_otp
        form_uuid = params[:form_uuid]
        visitor_uuid = params[:visitor_uuid]
        otp_code = params[:otp_code]

        form_otp_service = FormOtpService.new(form_uuid, [])

        begin
          response = form_otp_service.verify_otp(visitor_uuid, otp_code)
          render json: response, status: :ok
        rescue OtpVerificationError
          render json: { error: 'OTP is incorrect' }, status: :unprocessable_entity
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Form/Visitor UUID is invalid' }, status: :not_found
        end
      end

    end
  end
end
