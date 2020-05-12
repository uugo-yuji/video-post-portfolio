# == Schema Information
#
# Table name: post_category_relations
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  post_id     :bigint           not null
#
# Indexes
#
#  index_post_category_relations_on_category_id  (category_id)
#  index_post_category_relations_on_post_id      (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (post_id => posts.id)
#
require 'rails_helper'

RSpec.describe PostCategoryRelation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
