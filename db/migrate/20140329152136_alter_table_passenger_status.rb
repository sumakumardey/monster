class AlterTablePassengerStatus < ActiveRecord::Migration
  def up
  	add_column :passenger_status, :pnr_table_id, :integer
  end

  def down
  end
end
