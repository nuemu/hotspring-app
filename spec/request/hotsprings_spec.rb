RSpec.describe "Hotspring", type: :request do
  let(:hotspring){ create(:hotspring) }
  describe "GET /api/hotsprings" do
    it 'with resposne hotsprings' do
      hot = hotspring
      get '/api/hotsprings'
      expect(response).to have_http_status(200)
      expect(response.body).to include String(hot.latitude)
    end

    it 'hotsprings#show' do
      hot = hotspring
      get '/api/hotspring', { params: { 'lat': hot.latitude, 'lon': hot.longtitude } }
      expect(response).to have_http_status(200)
      expect(response.body).to include String(hot.latitude)
    end
  end
  describe "Post /api/hotsprings" do
    it 'is valid with correct params' do
      hot = build(:hotspring)
      post '/api/hotsprings', { params: { name: hot.name, 'latitude': hot.latitude, 'longtitude': hot.longtitude, 'description': hot.description } }
      expect(response).to have_http_status(200)
      expect(response.body).to include String(hot.latitude)
    end
    it 'is valid with empty name' do
      hot = build(:hotspring)
      post '/api/hotsprings', { params: { 'latitude': hot.latitude, 'longtitude': hot.longtitude, 'description': hot.description } }
      expect(response).to have_http_status(200)
      expect(response.body).to include '未探索'
    end
  end

  describe "Patch /api/hotsprings" do
    it 'is valid with correct params' do
      hot = hotspring
      patch '/api/hotsprings/'+String(hot.id), { params: { name: 'Update', 'latitude': hot.latitude, 'longtitude': hot.longtitude, 'description': hot.description } }
      expect(response).to have_http_status(200)
      expect(response.body).to include 'Update'
    end
  end
end
