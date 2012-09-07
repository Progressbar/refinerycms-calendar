module Refinery
  module Calendar
    module Admin
#      module CalendarEventsHelper
#
#        def user_can_modify_events?
#          (current_refinery_user.has_role?(:superuser) || current_refinery_user.authorized_plugins.include?("refinerycms_calendar"))
#        end
#
#        def user_can_modify_event? (event)
#          (current_refinery_user.has_role?(:superuser) || 
#            (current_refinery_user.authorized_plugins.include?("refinerycms_calendar") && (event.user_id == current_refinery_user.id || ::Refinery::Calendar.refinery_user_can_manage_events)))
#        end
#
#      	def user_can_modify_categories?
#          (current_refinery_user.has_role?(:superuser) || 
#            (current_refinery_user.authorized_plugins.include?("refinerycms_calendar") && 
#             ::Refinery::Calendar.refinery_user_can_manage_categories))
#      	end
#
#      	def user_can_modify_places?
#          (current_refinery_user.has_role?(:superuser) || 
#            (current_refinery_user.authorized_plugins.include?("refinerycms_calendar") && 
#              ::Refinery::Calendar.refinery_user_can_manage_places))
#      	end
#
#      end
    end
  end
end

