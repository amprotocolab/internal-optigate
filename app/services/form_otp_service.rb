# app/services/form_otp_service.rb
class FormOtpService
  def initialize(form_uuid, form_fields)
    @form = Form.find_by!(uuid: form_uuid)
    @form_fields = form_fields
    @visitor = nil
  end

  def generate_otp_and_send
    verify_mandatory_fields

    create_visitor

    otp_service = OtpService.new(@visitor.phone_number)
    otp_code = otp_service.send_otp

    { form_uuid: @form.uuid, visitor_uuid: @visitor.uuid, otp_code: otp_code }
  end

  private

  def verify_mandatory_fields
    missing_fields = @form_fields.select { |field| field['form_field_value'].blank? }

    raise MissingMandatoryFieldsError.new(missing_fields) if missing_fields.present?
  end

  def create_visitor
    @visitor = @form.visitors.create!(
      title: @form_fields.find { |field| field['form_field_uuid'] == 'title' }['form_field_value'],
      email: @form_fields.find { |field| field['form_field_uuid'] == 'email' }['form_field_value'],
      phone_number: @form_fields.find { |field| field['form_field_uuid'] == 'phone_number' }['form_field_value'],
      company: @form_fields.find { |field| field['form_field_uuid'] == 'company' }['form_field_value']
    )
  end
end
