RSpec.describe 'Hotspring', type: :system, js: true do
  describe 'hotsprings on map' do
    context 'index page' do
      it 'index page' do
        visit root_path
        expect(page).to have_content 'ゆtellite'
      end
    end
  end
end
