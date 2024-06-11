class CreateDrivingDistances < ActiveRecord::Migration[6.1]
  def change
    create_table :driving_distances do |t|

      t.integer :user_id
      t.integer :car_model_id
      t.string :distance
      t.timestamps
    end
  end
end
