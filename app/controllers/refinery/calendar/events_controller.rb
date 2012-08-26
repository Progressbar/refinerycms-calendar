module Refinery
  module Calendar
    class EventsController < ::ApplicationController

      before_filter :find_page, :get_events, :get_categories

      respond_to :html, :ics
      
      def index
        @events = @events.upcoming.paginate({
          :page => params[:page],
          :per_page => ::Refinery::Calendar.events_per_page
        })

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def show
        @event = @events.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end
 
      def archive
        if request.xhr?
          date = "#{params[:month]}/#{params[:year]}"
          @archive_date = Time.parse(date)
          @events = @events.by_archive(@archive_date).all
          render :json => @events
        else
          if params[:month].present?
            date = "#{params[:month]}/#{params[:year]}"
            @archive_date = Time.parse(date)
            @date_title = @archive_date.strftime('%B %Y')
            @events = @events.by_archive(@archive_date).paginate({
                :page => params[:page],
                :per_page => ::Refinery::Calendar.events_per_page
              })
          else
            date = "01/#{params[:year]}"
            @archive_date = Time.parse(date)
            @date_title = @archive_date.strftime('%Y')
            @events = @events.by_year(@archive_date).paginate({
                :page => params[:page],
                :per_page => ::Refinery::Calendar.events_per_page
              })
          end
       
          present (@page)
        end
      end

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url("/calendar")
        end

        def get_events
          @events = Event.live
        end

        def get_categories
          @categories = Category.all
        end
    end
  end
end
