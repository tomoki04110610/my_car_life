class ChangeDistanceDataTypeInDrivingDistances < ActiveRecord::Migration[6.1]
  def change
    change_column :driving_distances, :distance, :integer
  end
end
