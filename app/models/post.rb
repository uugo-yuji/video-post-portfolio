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
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations
  has_many :bookmarks
  has_many :bookmarked_users, through: :bookmarks, source: :user
  
  validates :title, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 1000}

  mount_uploader :video, VideoAndImageUploader

  # post,bookmarkの判定
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

    # enumでの未解決or解決済
    enum status: { unfixed: false, resolved: true}
    # eunmでの切り替え用メソッド
    def toggle_status!
      if unfixed?
        resolved!
      else
        unfixed!
      end
    end
end
