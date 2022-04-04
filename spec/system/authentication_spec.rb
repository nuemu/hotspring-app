RSpec.describe 'Authentication', type: :system do
  let(:user) { create(:user) }
  describe 'register' do
    context '' do
      it 'filled' do
        visit root_path
        click_link '始める♨︎', match: :first
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ログイン/新規登録'
        click_button '新規登録'
        fill_in 'name', with: 'sample'
        fill_in 'password', with: 'password'
        click_button 'Submit'
        find('.navbar-toggler').click
        expect(page).to have_content('sample')
      end
      it 'without name filled' do
        visit root_path
        click_link '始める♨︎', match: :first
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ログイン/新規登録'
        click_button '新規登録'
        fill_in 'password', with: 'password'
        click_button 'Submit'
        expect(page).to have_content('登録失敗しました')
      end
    end
  end

  describe 'login' do
    context '' do
      it 'filled' do
        visit root_path
        click_link '始める♨︎', match: :first
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ログイン/新規登録'
        fill_in 'name', with: user.name
        fill_in 'password', with: 'password'
        click_button 'Submit'
        find('.navbar-toggler').click
        expect(page).to have_content(user.name)
      end
    end
  end
end
