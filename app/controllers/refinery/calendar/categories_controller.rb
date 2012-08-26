module Refinery
  module Calendar
    class CategoriesController < ::ApplicationController

      before_filter :find_page

      def show
        @category = Category.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url("/calendar")
        end
    end
  end
end
