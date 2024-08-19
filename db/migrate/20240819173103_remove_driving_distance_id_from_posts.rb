class RemoveDrivingDistanceIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :driving_distance_id, :integer
  end
end
