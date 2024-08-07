class CreateDefaultValues < ActiveRecord::Migration[6.1]
  def change
    create_table :default_values do |t|
      t.integer "user_id"
      t.integer "genre_id"
      t.integer "car_model_id"
      t.integer "default_oil_change_mileage", default:10000
      t.integer "default_oil_change_days", default:30
      t.integer "default_carwash_days", default:30

      t.timestamps
    end
  end
end
