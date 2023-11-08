require 'rails_helper'

RSpec.describe 'User' do
  include_context 'GraphQL test'

  describe 'users' do
    let!(:user1) { create(:user, first_name: 'second') }
    let!(:user2) { create(:user, first_name: 'second first') }

    let(:query) do
      <<~GRAPHQL
        {
          users(query: "second", sortColumn: FIRST_NAME) {
            nodes {
              uuid
              firstName
            }
          }
        }
      GRAPHQL
    end

    it 'paginates users' do
      expect(response.dig(:data, :users, :nodes)).to match(
        contain_exactly(
          {
            uuid:      user2.uuid,
            firstName: 'second first'
          },
          {
            uuid:      user1.uuid,
            firstName: 'second'
          }
        )
      )
    end
  end

  describe 'updateUser' do
    let!(:user)  { create(:user, last_name: 'new name') }
    let(:new_phone_number) { '03001234567' }

    let(:query) do
      <<~GRAPHQL
        mutation {
          updateUser(
            uuid:        "#{user.uuid}",
            phoneNumber:  "#{new_phone_number}"
          ) {
            user {
              uuid
              phoneNumber
            }
          }
        }
      GRAPHQL
    end

    it 'updates a user' do
      expect do
        response
        user.reload
      end.to change(user, :phone_number).to(new_phone_number)

      expect(response.dig(:data, :updateUser, :user)).to include(
        uuid:  user.uuid,
        phoneNumber: new_phone_number
      )
    end
  end

end
