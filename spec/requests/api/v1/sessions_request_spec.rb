require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  fixtures :users

  let(:user) { users :user1 }

  describe 'POST /create' do
    context 'with existing user' do
      before(:each) { sign_out user }
      it 'returns http success' do
        post '/api/v1/sessions/create',
             params: { user: { email: user.email, password: '123123' } }
        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)
        expect(body.keys).to match_array(%w[id email authentication_token])
        expect(body['authentication_token']).to_not be_nil
        expect(body['authentication_token']).to_not be_empty
      end
      it 'returns http unauthorized if wrong password' do
        post '/api/v1/sessions/create',
             params: { user: { email: user.email, password: 'qweasd' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context 'with non-existing user' do
      it 'returns http unauthorized' do
        post '/api/v1/sessions/create',
             params: { user: { email: 'fake@email', password: '123123' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      sign_in user
      delete '/api/v1/sessions/destroy', headers: {
        'X-User-Email': user.email, 'X-User-Token': user.authentication_token
      }
      expect(response).to have_http_status(:no_content)
      expect { user.reload }.to change(user, :authentication_token)
    end
  end
end
