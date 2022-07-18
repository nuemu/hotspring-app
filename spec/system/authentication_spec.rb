RSpec.describe 'Authentication', type: :system, js: true do
  let(:user) { create(:user) }
  describe 'register' do
    context '' do
      it 'filled' do
        visit root_path
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ユーザー登録'
        fill_in 'name', with: 'sample'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
        expect(page).to have_content('温泉数')
      end

      it 'without name filled' do
        visit root_path
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ユーザー登録'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button '登録'
        expect(page).to have_content('新規登録')
      end

      it 'without password_confirmation filled' do
        visit root_path
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ユーザー登録'
        fill_in 'name', with: 'sample'
        fill_in 'password', with: 'password'
        click_button '登録'
        expect(page).to have_content('新規登録')
      end

      it 'is invalid with same user' do
        user = create(:user, name: 'sample')
        visit root_path
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ユーザー登録'
        fill_in 'name', with: 'sample'
        fill_in 'password', with: 'password'
        fill_in 'password', with: 'password_confirmation'
        click_button '登録'
        expect(page).to have_content('新規登録')
      end
    end
  end

  describe 'login' do
    context '' do
      it 'filled' do
        user = create(:user, name: 'sample')
        visit root_path
        click_button '同意'
        find('.navbar-toggler').click
        click_link 'ログイン'
        fill_in 'name', with: user.name
        fill_in 'password', with: 'password'
        # click_button 'ログイン' 原因不明、Dockerと共有されてない？
        click_button '登録'
        expect(page).to have_content(user.name)
      end
    end
  end
end
