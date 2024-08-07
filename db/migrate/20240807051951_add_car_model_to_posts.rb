class AddCarModelToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :car_model, foreign_key: true
  end
end
