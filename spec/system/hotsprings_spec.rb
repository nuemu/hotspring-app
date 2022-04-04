RSpec.describe 'Authentication', type: :system do
  describe 'hotsprings on map' do
    context 'register' do
      fit 'map click' do
        visit root_path
        click_link '始める♨︎', match: :first
        click_button '同意'
        page.find('li', text: '野湯登録').click()
        page.find('#map').click([], { x: 300, y: 300 })
        fill_in 'description', with: 'description'
        click_button '+'
        page.find('li', text: '-').click()
        page.find('#map').click([], { x: 300, y: 300 })
        expect(page).to have_content '未探索'
      end
    end
  end
end
