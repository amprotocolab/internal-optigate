require 'rails_helper'

RSpec.describe 'Forms GraphQL API', type: :request do
  include_context 'GraphQL test'

  let(:base_query) { '/graphql' }  # Adjust based on your actual GraphQL endpoint

  describe 'CreateForm' do
    let(:form_attributes) { attributes_for(:form).transform_keys(&:to_s) }
    let(:form_fields_attributes) { attributes_for_list(:form_field, 3).map(&:transform_keys(&:to_s)) }
    let(:visitors_attributes) { attributes_for_list(:visitor, 2).map(&:transform_keys(&:to_s)) }
    let(:variables) {
      {
        formAttributes: form_attributes,
        formFieldsAttributes: form_fields_attributes,
        visitorsAttributes: visitors_attributes
      }
    }

    let(:query) do
      <<~GRAPHQL
        mutation CreateForm($formAttributes: FormInputType!, $formFieldsAttributes: [FormfieldInputType]!, $visitorsAttributes: [VisitorInputType]!) {
          createForm(
            formAttributes: $formAttributes
            formFieldsAttributes: $formFieldsAttributes
            visitorsAttributes: $visitorsAttributes
          ) {
            id
            title
            formFields {
              id
              label
            }
            visitors {
              id
              email
            }
          }
        }
      GRAPHQL
    end

    it 'successfully creates a form with associations' do
      expect {
        post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json' }
      }.to change(Form, :count).by(1)
         .and change(FormField, :count).by(3)
         .and change(Visitor, :count).by(2)

      json_response = JSON.parse(response.body)
      expect(json_response.dig('data', 'createForm')).to include(
        'title' => form_attributes['title'],
        'formFields' => a_collection_containing_exactly(
          *form_fields_attributes.map { |attr| include('label' => attr['label']) }
        ),
        'visitors' => a_collection_containing_exactly(
          *visitors_attributes.map { |attr| include('email' => attr['email']) }
        )
      )
    end
  end

  describe 'UpdateForm' do
    let!(:form) { create(:form, title: 'Initial Title') }
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
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json' }
      form.reload
      expect(form.title).to eq(new_title)
    end
  end

  describe 'ArchiveForm' do
    let!(:form) { create(:form, state: 'published') }
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
      post base_query, params: { query: query, variables: variables.to_json }, headers: { 'Content-Type' => 'application/json' }
      form.reload
      expect(form.state).to eq('archived')
    end
  end
end
