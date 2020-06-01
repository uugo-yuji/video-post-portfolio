require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  # ユーザが新しい質問を作成する
  scenario "user creates a new post" do
    user = FactoryBot.create(:user)

    visit root_path
    within "dropdown-menu" do
      click_link "ログイン"
    end
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect {
      click_link "質問する"
      fill_in "タイトル", with: "Test Title"
      fill_in "content", with: "Test Content"
      click_button "保存"

      expect(page).to have_content "『#{user.post.title}』を作成しました"
      expect(page).to have_content "Tset Title"
    }.to change(user.posts, :count).by(1)
  end
end
