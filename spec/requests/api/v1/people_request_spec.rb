# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::People', type: :request do
  fixtures :users
  fixtures :people

  describe 'GET /whoami' do
    let(:user) { users :user1 }
    context 'with logged user' do
      it 'returns http success' do
        sign_in user
        get '/api/v1/people/whoami', headers: {
          'X-User-Email': user.email, 'X-User-Token': user.authentication_token
        }
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['id']).to_not be_blank
        expect(body['firstname']).to_not be_blank
        expect(body['lastname']).to_not be_blank
        expect(body['age']).to_not be_blank
      end
    end
    context 'with no logged user' do
      it 'returns http unauthorized' do
        sign_in user
        original_token = user.authentication_token
        sign_out user
        get '/api/v1/people/whoami', headers: {
          'X-User-Email': user.email, 'X-User-Token': original_token
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context 'with unregistered user' do
      it 'returns http unauthorized' do
        get '/api/v1/people/whoami'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
