module Refinery
  module Calendar
    class PlacesController < CalendarController

      def show
        @place = Place.find(params[:id])
        
        present(@page)
      end

    end
  end
end
