# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  price      :string(255)
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
  has_many :post_tag_relations, dependent: :delete_all
  has_many :tags, through: :post_tag_relations
  
  validates :title, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 1000}

  mount_uploader :video, VideoAndImageUploader
end
