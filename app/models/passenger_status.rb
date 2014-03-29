class PassengerStatus < ActiveRecord::Base
  attr_accessible :pnr_number, :s_no, :booking_status, :current_status, :pnr_table_id
  set_table_name :passenger_status
end
