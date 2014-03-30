class PassengerStatusGen < ActiveRecord::Base
  attr_accessible :pnr_number, :s_no, :booking_status, :current_status, :pnr_table_id, :updated_at, :nth_date, :seat_moved
  set_table_name :passenger_status_gen
end
