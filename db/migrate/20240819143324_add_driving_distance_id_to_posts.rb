class AddDrivingDistanceIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :driving_distance_id, :integer
  end
end
