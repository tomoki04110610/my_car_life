class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer "user_id"
      t.integer "post_id"
      t.string "message"
      t.integer "car_model_id"

      t.timestamps
    end
  end
end
