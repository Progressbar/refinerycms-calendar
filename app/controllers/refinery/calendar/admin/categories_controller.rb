module Refinery
  module Calendar
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/calendar/category',
                :order => 'title ASC'

      end
    end
  end
end
