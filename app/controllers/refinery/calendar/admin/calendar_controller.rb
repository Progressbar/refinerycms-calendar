module Refinery
  module Calendar
    module Admin
      class CalendarController < ::Refinery::AdminController
		include CalendarHelper

		protected

		def group_by_date(records, date=:created_at)
	        new_records = []

	        records.each do |record|
	          key = record[date].strftime("%Y-%m-%d")
	          record_group = new_records.collect{|records| records.last if records.first == key }.flatten.compact << record
	          (new_records.delete_if {|i| i.first == key}) << [key, record_group]
	        end

	        new_records
	    end
      end
    end
  end
end