class AlterTablePnrStatus < ActiveRecord::Migration
  def up
  	rename_column :pnr_table, :class, :seat_class
  end

  def down
  end
end
