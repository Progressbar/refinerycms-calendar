module Refinery
  module Calendar
    class EventsController < ::ApplicationController

      before_filter :find_page
      
      def index

        @events = Event.live.upcoming

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def show
        @event = Event.live.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def archive
        #   @events = Event.live.archive.order('refinery_calendar_events.from DESC')
        render :template => 'refinery/calendar/events/index'
      end

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url("/calendar")
        end
    end
  end
end
