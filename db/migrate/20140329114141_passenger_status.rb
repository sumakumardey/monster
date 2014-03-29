class PassengerStatus < ActiveRecord::Migration
  def up
  	create_table :passenger_status do |t|
      t.string :pnr_number, :limit => 15
      t.string :s_no, :limit => 15
      t.string :booking_status, :limit => 20
      t.string :current_status, :limit => 20			
      t.timestamps
    end
  end

  def down
  	drop_table :passenger_status
  end
end
