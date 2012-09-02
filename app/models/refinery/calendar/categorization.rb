module Refinery
	module Calendar
		class Categorization < ActiveRecord::Base

			self.table_name = 'refinery_calendar_events_categorization'
			belongs_to :calendar_event, :class_name => 'Refinery::Calendar::Event', :foreign_key => :calendar_event_id
			belongs_to :calendar_category, :class_name => 'Refinery::Calendar::Category', :foreign_key => :calendar_category_id

			attr_accessible :calendar_event_id, :calendar_category_id
		end
	end
end
