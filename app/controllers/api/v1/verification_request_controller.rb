module API
  module V1
    class VerificationRequestsController < ApplicationController
      def verify_otp
        # Get subscriber and form based on params
        subscriber = Subscriber.find(params[:subscriber_id])
        form = Form.find(params[:form_id])

        # Verify OTP
        if verify_otp(subscriber, form, params[:user_provided_otp])
          render json: { status: 'OTP verified' }
        else
          render json: { status: 'OTP not verified' }
        end
      end

      def create_verification_request
        subscriber = Subscriber.create!(phone_number: params[:phone_number])
        form = Form.find(params[:form_id])

        otp_service = OtpService.new(subscriber.phone_number)
        otp_code = otp_service.send_otp

        verification_request = VerificationRequest.create!(
          subscriber: subscriber,
          form: form,
          otp_code: otp_code
        )

        render json: {
          status: 'OTP sent',
          subscriber_uuid: subscriber.uuid,
          form_uuid: form.uuid
        }
      end

      private

      def verify_otp(subscriber, form, user_provided_otp)
        otp_service = OtpService.new(subscriber.phone_number)
        generated_otp = otp_service.send_otp # If we generate OTP for subscribers

        otp_service.verify_otp?(generated_otp, user_provided_otp)
      end
    end
  end
end
