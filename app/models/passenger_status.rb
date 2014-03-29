class PassengerStatus < ActiveRecord::Base
  attr_accessible :pnr_number, :s_no, :booking_status, :current_status
  set_table_name :passenger_status
end
