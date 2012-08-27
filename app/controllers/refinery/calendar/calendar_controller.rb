module Refinery
  module Calendar
    class CalendarController < ::ApplicationController

      before_filter :find_page, :get_categories

      respond_to :html, :ics

      protected

      def find_page
        @page = Refinery::Page.find_by_link_url("/calendar")
      end

      def get_categories
        @categories = Category.all
      end
    end
  end
end
