require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # 名前,メール,パスワードがあれば有効なこと
  it "is valid with a name, email, password" do
    user = User.new(
      name: "SampleTest",
      email: "sample@example.com",
      password: "sampletestpassword"
    )
    expect(user).to be_valid
  end

  # 名前がなければ無効なこと
  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors.added?(:name, :blank)).to be_truthy
  end

  # メールアドレスがなければ無効なこと
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors.added?(:email, :blank)).to be_truthy
  end

  # 重複したメールアドレスなら無効なこと
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "test@exmple.com")
    user = FactoryBot.build(:user, email: "test@exmple.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  # パスワードが6文字以下だと無効なこと
  it "is invalid with a shoot password" do
    user = User.new(password: 'a' * 5)
    user.valid?
    expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
  end

  # パスワードと確認用パスワードが一致しないなら無効なこと
  it "If the password does not match the confirmation password, it is invalid" do
    user = FactoryBot.build(:user, password: 'sample', password_confirmation: '123456')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

end
