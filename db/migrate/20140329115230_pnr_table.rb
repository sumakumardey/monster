class PnrTable < ActiveRecord::Migration
  def up
  	create_table :pnr_table do |t|
  		t.string :pnr_number, :limit => 10
  		t.string :train_number, :limit => 10
  		t.string :train_name, :limit => 40
  		t.datetime :boarding_date
  		t.string :starting_point, :limit => 10
  		t.string :ending_point, :limit => 10
  		t.string :reserved_upto, :limit=> 20
  		t.string :boarding_point, :limit => 20
  		t.string :class, :limit => 10
  	end
  end

  def down
  	drop_table :pnr_table
  end
end