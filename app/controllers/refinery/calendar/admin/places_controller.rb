module Refinery
  module Calendar
    module Admin
      class PlacesController < CalendarController
        include CalendarHelper

        crudify :'refinery/calendar/place',
          :title_attribute => 'name',
          :xhr_paging => true,
          :sortable => false,
          :order => 'created_at DESC'


        before_filter :check_acl

        private

        def check_acl
          error_404 unless user_can_modify_categories
        end
      end
    end
  end
end
