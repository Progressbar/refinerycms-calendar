module Refinery
  module Calendar
    module Admin
      class CalendarController < ::Refinery::AdminController
        # reinclude because weird bug when searching? method is sometimes not present ;(
        include Refinery::Admin::BaseController

        include CalendarHelper
      end
    end
  end
end