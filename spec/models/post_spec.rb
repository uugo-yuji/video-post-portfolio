# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  price      :string(255)
#  status     :boolean          default(FALSE), not null
#  title      :string(255)
#  video      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:post)).to be_valid
  end

    # タイトルが30文字以上だと無効なこと
    it "is invalid with a more title" do
      post = build(:post, title: 'a' * 31)
      post.valid?
      expect(post.errors[:title][0]).to include("は30文字以内で入力してください")
    end

    # 本文が1000文字以上だと無効なこと
    it "is invalid with a more content" do
      post = build(:post, content: 'a' * 1001)
      post.valid?
      expect(post.errors[:content][0]).to include("")
    end
end
