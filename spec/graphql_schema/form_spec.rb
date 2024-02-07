# spec/graphql_schema/forms_spec.rb
require 'rails_helper'

RSpec.describe 'Forms' do
  include_context 'GraphQL test'

  describe 'createForm' do
    let(:form_attributes) { build(:form).attributes }
    let(:form_fields_attributes) { build_list(:form_field, 3).map(&:attributes) }
    let(:visitors_attributes) { build_list(:visitor, 2).map(&:attributes) }

    let(:query) do
      <<~GRAPHQL
        mutation {
          createFormWithAssociations(
            formAttributes: #{form_attributes}
            formFieldsAttributes: #{form_fields_attributes}
            visitorsAttributes: #{visitors_attributes}
          ) {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'creates a form with associations' do
      expect do
        response
      end.to change(Form, :count).by(1)

      expect(response.dig(:data, :createFormWithAssociations)).to include(
        id: anything,
        title: form_attributes['title']
      )
    end
  end

  describe 'updateForm' do
    let!(:form) { create(:form) }
    let(:new_title) { 'Updated Title' }

    let(:query) do
      <<~GRAPHQL
        mutation {
          updateForm(
            id: "#{form.id}"
            title: "#{new_title}"
          ) {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'updates a form' do
      response
      form.reload

      expect(form.title).to eq(new_title)
    end
  end

  describe 'archiveForm' do
    let!(:form) { create(:form) }

    let(:query) do
      <<~GRAPHQL
        mutation {
          archiveForm(
            id: "#{form.id}"
          ) {
            id
            state
          }
        }
      GRAPHQL
    end

    it 'archives a form' do
      response
      form.reload

      expect(form.state).to eq('archived')
    end
  end

  describe 'readForm' do
    let!(:form) { create(:form) }

    let(:query) do
      <<~GRAPHQL
        {
          readForm(id: "#{form.id}") {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'reads a form' do
      expect(response.dig(:data, :readForm)).to include(
        id: form.id.to_s,
        title: form.title
      )
    end
  end

  describe 'indexForms' do
    let!(:forms) { create_list(:form, 3) }

    let(:query) do
      <<~GRAPHQL
        {
          indexForms {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'lists all forms' do
      expect(response.dig(:data, :indexForms).count).to eq(forms.count)
    end
  end

  describe 'showForm' do
    let!(:form) { create(:form) }

    let(:query) do
      <<~GRAPHQL
        {
          showForm(uuid: "#{form.uuid}") {
            id
            title
          }
        }
      GRAPHQL
    end

    it 'shows a form' do
      expect(response.dig(:data, :showForm)).to include(
        id: form.id.to_s,
        title: form.title
      )
    end
  end
end
