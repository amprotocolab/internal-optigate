require 'rails_helper'

RSpec.describe 'Users API' do
  context 'when user is a agency admin' do
    let!(:user)           { create(:user) }
    let(:user_attributes) { attributes_for(:user) }

    describe 'GET: /api/v1/users' do
      it 'returns a list of users' do
        get '/api/v1/users',
          headers: auth_headers_for(user)
        expect(json_response.count).to eq(1)
        expect(json_response.first).to include(
          uuid: user.uuid,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          phone_number: user.phone_number,
          roles: [hash_including(name: Role::PERMITTED.fetch(:agency_admin))]
        )
      end

      it 'returns an error on list of users' do
        get '/api/v1/users'
        expect(json_response).to include(
          errors: ["You need to sign in or sign up before continuing."]
        )
      end

    end

    describe 'GET: /api/v1/users/:id' do
      let!(:user1) { create(:user, :app_user) }

      it 'returns a single of users' do
        get "/api/v1/users/#{user1.id}",
          headers: auth_headers_for(user)

        expect(json_response).to include(
          uuid: user1.uuid,
          first_name: user1.first_name,
          last_name: user1.last_name,
          email: user1.email,
          phone_number: user1.phone_number,
          roles: [hash_including(name: Role::PERMITTED.fetch(:app_user))],
        )
      end

      it 'returns an error on single of users' do
        get "/api/v1/users/#{user1.id}"

        expect(json_response).to include(
          errors: ["You need to sign in or sign up before continuing."]
        )
      end
    end

    describe 'POST: /api/v1/users' do
      it 'creates a new user' do
        expect do
          post '/api/v1/users',
            headers: auth_headers_for(user),
            params: {
              user: user_attributes.merge(role_ids: [Role.app_user.id], image: fixture_file_upload(Rails.root.join('spec', 'support', 'test12.jpg'), 'image/jpg'))
            }
        end.to change(User, :count).by(1)

        new_user = User.last
        expect(response).to be_json
        expect(response).to be_created
        expect(json_response).to include(
          uuid: new_user.uuid,
          first_name: new_user.first_name,
          last_name: new_user.last_name,
          email: new_user.email,
          phone_number: new_user.phone_number,
          roles: [hash_including(name: Role::PERMITTED.fetch(:app_user))],
        )
      end
    end

    describe 'PUT: /api/v1/users/:id' do

      context 'User Update' do
        it 'updates a user' do
          put "/api/v1/users/#{user.id}",
            headers: auth_headers_for(user),
            params: {
              user: user_attributes.except(:password).merge(role_ids: [Role.app_user.id], image: fixture_file_upload(Rails.root.join('spec', 'support', 'test12.jpg'), 'image/jpg'))
            }
          expect(json_response).to include(
            uuid: user.uuid,
            first_name: user_attributes[:first_name],
            last_name: user_attributes[:last_name],
            email: user_attributes[:email],
            phone_number: user_attributes[:phone_number],
            roles: [hash_including(name: Role::PERMITTED.fetch(:app_user))],
          )
        end
      end

      context 'User Update without login' do
        it 'updates a user without login' do
          put "/api/v1/users/#{user.id}",
            params: {
              user: user_attributes.except(:password).merge(role_ids: [Role.app_user.id])
            }
          expect(json_response).to include(
            errors: ["You need to sign in or sign up before continuing."]
          )
        end
      end
    end

    describe 'DELETE: /api/v1/users/:id' do
      let!(:deletable_user) { create(:user) }

      it 'deletes a user' do
        expect do
          delete "/api/v1/users/#{deletable_user.id}", headers: auth_headers_for(user)
        end.to change(User, :count).by(-1)

        expect(response).to be_no_content
      end
    end
  end
end
