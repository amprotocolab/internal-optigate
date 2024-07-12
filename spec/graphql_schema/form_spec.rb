# spec/graphql_schema/form_spec.rb
require 'rails_helper'

RSpec.describe 'Forms GraphQL API', type: :request do
  include_context 'GraphQL test'

  describe 'CreateForm' do
    let(:user) { create(:user) }
    let(:new_uuid) { SecureRandom.uuid }
    let(:new_form_type) { 0 }  # Corresponds to 'modal' in FormTypeEnum
    let(:new_title) { 'Test Form' }
    let(:new_html_script) { '<p>Test HTML</p>' }
    let(:new_state) { 'unpublished' }  # Adjust based on your possible states
    let(:email_confirmation_with_otp) { false }
    let(:thank_you_message) { false }

    let(:variables) {
      {
        uuid: new_uuid,
        formType: new_form_type,
        title: new_title,
        htmlScript: new_html_script,
        state: new_state,
        emailConfirmationWithOtp: email_confirmation_with_otp,
        thankYouMessage: thank_you_message,
        formFieldsAttributes: [
          {
            uuid: SecureRandom.uuid,
            fieldType: 0,  # Corresponds to 'button' in FormFieldTypeEnum
            customCss: '{}',
            label: 'Submit',
            fontType: 'Arial',
            fontSize: 12,
            fontFamily: 'Arial',
            fillColor: '#ffffff',
            fillColorPercent: 100,
            alignmentType: 1  # Corresponds to 'center' in AlignmentTypeEnum
          }
        ]
      }
    }

    let(:query) do
      <<~GRAPHQL
        mutation CreateForm($uuid: String!, $formType: Int!, $title: String!, $htmlScript: String, $state: String!, $emailConfirmationWithOtp: Boolean!, $thankYouMessage: Boolean!, $formFieldsAttributes: [FormFieldInputType!]) {
          createForm(
            uuid: $uuid,
            formType: $formType,
            title: $title,
            htmlScript: $htmlScript,
            state: $state,
            emailConfirmationWithOtp: $emailConfirmationWithOtp,
            thankYouMessage: $thankYouMessage,
            formFieldsAttributes: $formFieldsAttributes
          ) {
            id
            uuid
            formType
            title
            htmlScript
            state
            emailConfirmationWithOtp
            thankYouMessage
            formFields {
              uuid
              label
            }
          }
        }
      GRAPHQL
    end

    it 'successfully creates a form with nested form fields' do
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{user.auth_token}" }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      form_data = json_response.dig('data', 'createForm')

      expect(form_data).to include(
        'uuid' => new_uuid,
        'formType' => new_form_type,
        'title' => new_title,
        'htmlScript' => new_html_script,
        'state' => new_state,
        'emailConfirmationWithOtp' => email_confirmation_with_otp,
        'thankYouMessage' => thank_you_message
      )

      expect(form_data['formFields'].first).to include(
        'label' => 'Submit'
      )
    end
  end

  describe 'UpdateForm' do
    let(:user) { create(:user) }
    let!(:form) { create(:form, user: user, title: 'Initial Title', uuid: SecureRandom.uuid) }
    let(:new_title) { 'Updated Title' }
    let(:form_field_uuid) { form.form_fields.create!(field_type: 0, custom_css: '{}', label: 'Old Label', font_type: 'Arial', font_size: 12, font_family: 'Arial', fill_color: '#ffffff', fill_color_percent: 100, alignment_type: 1).uuid }

    let(:variables) {
      {
        uuid: form.uuid,
        title: new_title,
        formFieldsAttributes: [
          {
            uuid: form_field_uuid,
            label: 'Updated Label'
          }
        ]
      }
    }

    let(:query) do
      <<~GRAPHQL
        mutation UpdateForm($uuid: String!, $title: String!, $formFieldsAttributes: [FormFieldInputType!]) {
          updateForm(
            uuid: $uuid,
            title: $title,
            formFieldsAttributes: $formFieldsAttributes
          ) {
            id
            uuid
            title
            formFields {
              uuid
              label
            }
          }
        }
      GRAPHQL
    end

    it 'updates the title and nested form fields of a form' do
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{user.auth_token}" }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      form_data = json_response.dig('data', 'updateForm')

      expect(form_data).to include(
        'uuid' => form.uuid,
        'title' => new_title
      )

      expect(form_data['formFields'].first).to include(
        'uuid' => form_field_uuid,
        'label' => 'Updated Label'
      )

      form.reload
      expect(form.title).to eq(new_title)
      expect(form.form_fields.first.label).to eq('Updated Label')
    end
  end

  describe 'ArchiveForm' do
    let(:user) { create(:user) }
    let!(:form) { create(:form, user: user, state: 'published', uuid: SecureRandom.uuid) }
    let(:variables) { { uuid: form.uuid } }

    let(:query) do
      <<~GRAPHQL
        mutation ArchiveForm($uuid: String!) {
          archiveForm(uuid: $uuid) {
            id
            state
          }
        }
      GRAPHQL
    end

    it 'archives a form' do
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{user.auth_token}" }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      form_data = json_response.dig('data', 'archiveForm')

      expect(form_data).to include(
        'id' => form.id.to_s,
        'state' => 'archived'
      )

      form.reload
      expect(form.state).to eq('archived')
    end
  end
end
