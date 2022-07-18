RSpec.describe 'Authentication', type: :request do
  describe 'GET /api/registers' do
    it 'success register with filled' do
      post '/api/registers', params: { name: 'sample', password: 'password', password_confirmation: 'password' }
      expect(response).to have_http_status(200)
      expect(response.body).not_to include 'failed'
    end
    it 'return failed without password filled' do
      post '/api/registers', params: { name: 'sample' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
    it 'return failed without password_confirmation filled' do
      post '/api/registers', params: { name: 'sample', password: 'password' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
    it 'return failed without name filled' do
      post '/api/registers', params: { password: 'password', password_confirmation: 'password' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
    it 'success register with short password' do
      post '/api/registers', params: { name: 'sample', password: 'pa', password_confirmation: 'pa' }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'failed'
    end
  end
end
