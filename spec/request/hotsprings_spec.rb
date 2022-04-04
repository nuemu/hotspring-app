RSpec.describe "Hotspring", type: :request do
  let(:hotspring){ create(:hotspring) }
  describe "GET /api/hotsprings" do
    it '#index' do
      hot = hotspring
      get '/api/hotsprings'
      expect(response).to have_http_status(200)
      expect(response.body).to include String(hot.latitude)
    end
  end
  describe "Post /api/hotsprings" do
    it 'with correct params' do
      hot = build(:hotspring)
      post '/api/hotsprings', { params: { name: hot.name, 'latitude': hot.latitude, 'longtitude': hot.longtitude, 'description': hot.description } }
      expect(response).to have_http_status(200)
      expect(response.body).to include String(hot.latitude)
    end
    it 'with empty name' do
      hot = build(:hotspring)
      post '/api/hotsprings', { params: { 'latitude': hot.latitude, 'longtitude': hot.longtitude, 'description': hot.description } }
      expect(response).to have_http_status(200)
      expect(response.body).to include '未探索'
    end
  end
end
