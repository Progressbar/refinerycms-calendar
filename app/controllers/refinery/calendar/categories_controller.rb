module Refinery
  module Calendar
    class CategoriesController < CalendarController

      def show
        @category = Category.find(params[:id])
        @category_events = @category.events.live.paginate({
          :page => params[:page],
          :per_page => ::Refinery::Calendar.events_per_page
        })

        present(@page)
      end

    end
  end
end
