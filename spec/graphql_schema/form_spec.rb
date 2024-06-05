require 'rails_helper'

RSpec.describe 'Forms GraphQL API', type: :request do
  include_context 'GraphQL test'


  describe 'CreateForm' do
    let(:user) { create(:user) }
    let(:new_uuid) { SecureRandom.uuid }
    let(:new_form_type) { 'modal' }  # Adjust based on your FormTypeEnum values
    let(:new_title) { 'Test Form' }
    let(:new_html_script) { '<p>Test HTML</p>' }
    let(:new_state) { 'unpublished' }  # Adjust based on your possible states

    let(:variables) {
      {
        uuid: new_uuid,
        formType: new_form_type,
        title: new_title,
        htmlScript: new_html_script,
        state: new_state
      }
    }

    let(:query) do
      <<~GRAPHQL
        mutation CreateForm($uuid: String!, $formType: FormTypeEnum!, $title: String!, $htmlScript: String, $state: String!) {
          createForm(
            uuid: $uuid,
            formType: $formType,
            title: $title,
            htmlScript: $htmlScript,
            state: $state
          ) {
            id
            uuid
            formType
            title
            htmlScript
            state
          }
        }
      GRAPHQL
    end

    it 'successfully creates a form' do
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{user.auth_token}" }
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      form_data = json_response.dig('data', 'createForm')
      
      expect(form_data).to include(
        'uuid' => new_uuid,
        'formType' => new_form_type,
        'title' => new_title,
        'htmlScript' => new_html_script,
        'state' => new_state
      )
    end
  end

  describe 'UpdateForm' do
    let(:user) { create(:user) }
    let!(:form) { create(:form, user: user, title: 'Initial Title') }
    let(:new_title) { 'Updated Title' }
    let(:variables) { { id: form.id.to_s, title: new_title } }

    let(:query) do
      <<~GRAPHQL
        mutation UpdateForm($id: ID!, $title: String!) {
          updateForm(id: $id, title: $title) {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'updates the title of a form' do
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{user.auth_token}" }
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      form_data = json_response.dig('data', 'updateForm')

      expect(form_data).to include(
        'id' => form.id.to_s,
        'title' => new_title
      )

      form.reload
      expect(form.title).to eq(new_title)
    end
  end

  describe 'ArchiveForm' do
    let(:user) { create(:user) }
    let!(:form) { create(:form, user: user, state: 'published') }
    let(:variables) { { id: form.id.to_s } }

    let(:query) do
      <<~GRAPHQL
        mutation ArchiveForm($id: ID!) {
          archiveForm(id: $id) {
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
