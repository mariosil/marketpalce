require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  fixtures :users

  describe 'POST /create' do
    context 'with existing user' do
      let(:user) { users :user1 }
      it 'returns http success' do
        post '/api/v1/sessions/create',
             params: { user: { email: user.email, password: '123123' } }
        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)
        expect(body.keys).to match_array(%w[id email authentication_token])
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

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/sessions/destroy'
      expect(response).to have_http_status(:no_content)
    end
  end

end
