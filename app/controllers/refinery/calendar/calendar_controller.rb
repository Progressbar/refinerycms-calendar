module Refinery
  module Calendar
    class CalendarController < ::ApplicationController

      include ControllerHelper

      before_filter :find_page

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url("/calendar")
        end
    end
  end
end
