module Refinery
  module Calendar
    module Admin
      class PlacesController < ::Refinery::AdminController

        crudify :'refinery/calendar/place',
                :title_attribute => 'name',
                :xhr_paging => true,
                :sortable => false,
                :order => 'created_at DESC'
      end
    end
  end
end
