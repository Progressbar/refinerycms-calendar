module Refinery
  module Calendar
    module Admin
      class CategoriesController < CalendarController

        crudify :'refinery/calendar/category',
          :order => 'title ASC'

        before_filter :check_acl

        private

        def check_acl
          error_404 unless user_can_modify_categories?
        end
      end
    end
  end
end