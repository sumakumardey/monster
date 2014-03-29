class PnrTableGen < ActiveRecord::Base
  attr_accessible :passenger_status,:pnr_number,:train_number, :train_name, :boarding_date, :starting_point, :ending_point, :reserved_upto, :boarding_point, :seat_class
  set_table_name :pnr_table_gen

  has_many :passenger_status, :class_name => "PassengerStatusGen"
end
