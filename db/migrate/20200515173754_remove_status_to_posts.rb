class RemoveStatusToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :status, :integer
  end
end
