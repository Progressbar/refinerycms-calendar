module Refinery
  module Calendar

    class Date < Refinery::Core::BaseModel
      belongs_to :event, :class_name => 'Refinery::Calendar::Event', :foreign_key => :event_id

      validates :date_time, :presence => true

      attr_accessible :date_time
    end
  end
end
