class ChangeDefaultValuesInDefaultValues < ActiveRecord::Migration[6.1]
  def change
    change_column_default :default_values, :default_oil_change_days, 90
    change_column_default :default_values, :default_oil_change_mileage, 5000
  end
end
