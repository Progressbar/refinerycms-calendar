module Refinery
  module Calendar
    module Admin
      module CalendarHelper

        def user_can_modify_events?
          (current_refinery_user.has_role?(:superuser) || current_refinery_user.authorized_plugins.include?('refinerycms_calendar'))
        end

        def user_can_modify_event? (event)
          (current_refinery_user.has_role?(:superuser) || 
            (current_refinery_user.authorized_plugins.include?('refinerycms_calendar') && (event.user_id == current_refinery_user.id || ::Refinery::Calendar.refinery_user_can_manage_events)))
        end

      	def user_can_modify_categories?
          (current_refinery_user.has_role?(:superuser) || 
            (current_refinery_user.authorized_plugins.include?('refinerycms_calendar') && 
             ::Refinery::Calendar.refinery_user_can_manage_categories))
      	end

      	def user_can_modify_places?
          (current_refinery_user.has_role?(:superuser) || 
            (current_refinery_user.authorized_plugins.include?('refinerycms_calendar') && 
              ::Refinery::Calendar.refinery_user_can_manage_places))
      	end

        def link_to_add_date(name, f, association)
          new_start_object = @event.dates.new(:date_time => Time.now.tomorrow.change(:hour => 18, :minute => 0))
          new_end_object = @event.dates.new(:date_time => Time.now.tomorrow.change(:hour => 20, :minute => 0))

          fields = '<div class="start-end-date-holder">'
          fields += f.fields_for(association, new_start_object, :child_index => "new_#{association}") do |builder|
            render(association.to_s.singularize + '_fields', :f => builder, 
              :start_date => true, 
              :show_switch_link => false, 
              :show_destroy_link => true)
            # render(association.to_s.singularize + '_fields', :f => builder, :start_date => false, :allow_destroy => true)
          end          
          fields += f.fields_for(association, new_end_object, :child_index => "new_#{association}") do |builder|
            render(association.to_s.singularize + '_fields', :f => builder, 
              :start_date => false, 
              :show_switch_link => false, 
              :show_destroy_link => true)
          end
          fields += '</div>'
          link_to_function(name, %Q{refinery.calendar.admin.addFields(this, "#{association}", "#{escape_javascript(fields)}")}.html_safe)
        end


      end
    end
  end
end