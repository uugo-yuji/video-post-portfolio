# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:post)).to be_valid
  end

  # コメント,ユーザid,ポストidがあれば有効なこと
  it "is valid with a user, project, and message" do
    comment = Comment.new(
      comment: "SampleComment",
      user: user,
      post: post,
    )
    expect(comment).to be_valid
  end


  # コメントがなければ無効なこと
  it "is invalid without a comment" do
    comment = FactoryBot.build(:comment, comment: nil)
    comment.valid?
    expect(comment.errors.added?(:comment, :blank)).to be_truthy
  end

  # コメント1000文字以上なら無効なこと
  it "is invalid without a a more comment" do
    comment = FactoryBot.build(:comment, comment: 'a' * 1001)
    comment.valid?
    expect(comment.errors[:comment]).to include("は1000文字以内で入力してください")
  end
end
