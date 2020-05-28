# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create(:category) }

    # 有効なファクトリを持つこと
    it "has a valid factory" do
      expect(FactoryBot.build(:category)).to be_valid
    end

    # 名前がなければ無効なこと
    it "is invalid without an name" do
      category = FactoryBot.build(:category, name: nil)
      category.valid?
      expect(category.errors.added?(:name, :blank)).to be_truthy
    end

    # カテゴリが30以上だと無効なこと
    it "is invalid without a a more name" do
      category = FactoryBot.build(:category, name: 'a' * 31)
      category.valid?
      expect(category.errors[:name]).to include("は30文字以内で入力してください")
    end
end
