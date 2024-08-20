class AddDistanceToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :distance, :integer
  end
end
