module Refinery
  module Calendar
    module Admin
      class EventsController < CalendarController

        crudify :'refinery/calendar/event',
          :xhr_paging => true,
          :sortable => false,
          :order => "'start_date' DESC"

        before_filter :find_all_categories,
          :only => [:new, :edit, :create, :update]

        before_filter :find_all_places,
          :only => [:new, :edit, :create, :update]

        before_filter :check_category_ids, :only => :update

        # todo before filter check acl
        before_filter :check_acl, :only => [:edit, :update]

        def create
          @event = Refinery::Calendar::Event.new(params[:event])
          @event[:user_id] = current_refinery_user.id

          if @event.valid? && @event.save
                      
            (request.xhr? ? flash.now : flash).notice = t(
              'refinery.crudify.created',
              :what => "'#{@event.title}'"
            )

            unless from_dialog?
              unless params[:continue_editing] =~ /true|on|1/
                redirect_back_or_default(refinery.calendar_admin_events_path)
              else
                unless request.xhr?
                  redirect_to :back
                else
                  render "/shared/message"
                end
              end
            else
              render :text => "<script>parent.window.location = '#{refinery.calendar_admin_events_url}';</script>"
            end
          else
            unless request.xhr?
              render :new
            else
              render :partial => "/refinery/admin/error_messages",
                :locals => {
                :object => @event,
                :include_object_name => true
              }
            end
          end
        end

        private

        def find_all_categories
          @categories = Refinery::Calendar::Category.find(:all)
        end

        def find_all_places
          @places = Refinery::Calendar::Place.find(:all)
        end

        def check_category_ids
          params[:event][:category_ids] ||= []
        end

        def check_acl
          error_404 unless user_can_modify_event(@event)
        end
      end
    end
  end
end
