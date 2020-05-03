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
  validates :title, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 1000}
end
