class AddDefaultToIsActive < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :is_active, true
  end
end
