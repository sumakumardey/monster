class AlterTablePassengerStatusGen < ActiveRecord::Migration
  def up
  	add_column :passenger_status_gen, :nth_date, :integer
  	add_column :passenger_status_gen, :seat_moved , :integer
  end

  def down
  end
end
