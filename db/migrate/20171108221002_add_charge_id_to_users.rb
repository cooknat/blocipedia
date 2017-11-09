class AddChargeIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :charge_id, :string
  end
end
