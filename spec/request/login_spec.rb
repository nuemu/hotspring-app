RSpec.describe 'Sessions Controller', type: :request do
  let(:user) { create(:user) }
  describe 'GET /api/sessions' do
    it 'success login with correct params' do
      post '/api/sessions', params: { name: user.name, password: 'password' }
      expect(response).to have_http_status(200)
      expect(response.body).not_to include 'failed'
    end
    it 'return failed with invalid password' do
      post '/api/sessions', params: { name: user.name, password: 'asdewq' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
    it 'return failed with invalid name' do
      post '/api/sessions', params: { name: 'not_user_name', password: 'password' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
  end
end
