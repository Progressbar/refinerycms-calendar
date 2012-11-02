module Refinery
  module Calendar
    class EventsController < CalendarController

      before_filter :get_events, :get_categories

      def index
        @events = @events.upcoming.paginate({
            :page => params[:page],
            :per_page => ::Refinery::Calendar.events_per_page
          })

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      rescue
        error_404
      end

      def show
        @event = @events.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      rescue
        error_404
      end

      def archive
        if request.xhr? or request.format =~ 'json'
          date = "#{params[:month]}/#{params[:year]}"
          @archive_date = Time.parse(date)
          @events = @events.by_archive(@archive_date) unless @events.empty?

          inc = [:image, :dates, :place, :categories].reject do |attr|
            params[attr].nil? || params[attr].blank? || params[attr] == 'false' || params[attr] == '0'
          end

          render :json => @events.all.to_json(:include => inc)
        else
          if params[:month].present?
            date = "#{params[:month]}/#{params[:year]}"
            @archive_date = Time.parse(date)
            @events = @events.by_month(@archive_date)
          else
            date = "01/#{params[:year]}"
            @archive_date = Time.parse(date)
            @events = @events.by_year(@archive_date)
          end

          @events = @events.paginate({
                :page => params[:page],
                :per_page => ::Refinery::Calendar.events_per_page
              })

          present (@page)
        end
      rescue
        error_404
      end

      private

      def get_events
        @events = Event.live
        @archive_events_dates = Event.live.select('start_date').for_archive_list
      end

    end
  end
end
