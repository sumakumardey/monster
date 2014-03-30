module Generator
  class Automater
    def self.generator(date)
      PnrTableGen.all.each do |data|
        number_of_times = 15
        r = Random.new
        booking_status = r.rand(0...100)
        current_status = booking_status
        while number_of_times > 0 do
          date = data.boarding_date - number_of_times.days
          delta = r.rand(0..15)
          current_status = (current_status-delta)
          current_booking = ((current_status>1)? "W/L #{current_status}" : "CNF")
          current_status_date = ((current_status>1)? "#{current_status}" : "0")
          PassengerStatusGen.create(:pnr_table_id => data.id,
                               :pnr_number => data.pnr_number,
                               :booking_status => booking_status,
                               :current_status => current_booking,
                               :updated_at => date,
                               :nth_date => number_of_times,
                               :seat_moved => delta )
          break if current_booking == "CNF"
          current_booking = ""
          number_of_times = number_of_times - 1
        end
      end
    end
  end
end

