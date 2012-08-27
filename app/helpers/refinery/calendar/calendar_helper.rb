module Refinery
  module Calendar
    module CalendarHelper
      
      def smart_date_for event
        result = ''
        if event.start_date.to_date == event.end_date.to_date
          result += '<span class="start_date">' + "#{event.start_date.strftime(t('start_date_smart_strftime', :scope => 'refinery.calendar'))}" + '</span>'
          result += " #{t('to', :scope => 'refinery.calendar')} "
          result += '<span class="end_date">' + "#{event.end_date.strftime(t('end_date_smart_strftime', :scope => 'refinery.calendar'))}" + '</span>'
        else
          result += '<span class="start_date">' + "#{event.start_date.strftime(t('strftime', :scope => 'refinery.calendar'))}" + '</span>'
          result += " #{t('until', :scope => 'refinery.calendar')} "
          result += '<span class="end_date">' + "#{event.end_date.strftime(t('strftime', :scope => 'refinery.calendar'))}" + '</span>'
        end

        result.html_safe
      end
      
      def events_archive_list events
        html = '<ul>'
        links = []
        super_old_links = []

        events.each do |e|
          if e.start_date >= Time.now.end_of_year.advance(:years => -3)
            links << e.start_date.strftime('%m/%Y')
          else
            super_old_links << e.start_date.strftime('01/%Y')
          end
        end

        links.uniq!
        super_old_links.uniq!
        prev_year = nil
        links.each do |l|
          year = l.split('/')[1]
          prev_year = year unless prev_year
          month = l.split('/')[0]
          count = Event.live.by_archive(Time.parse(l)).size
          text = t("date.month_names")[month.to_i] + " #{year} (#{count})"
          html << "</ul><ul>" if prev_year != year
          html << "<li>"
          html << link_to(text, refinery.calendar_archive_path(:year => year, :month => month))
          html << "</li>"
          prev_year = year
        end
        super_old_links.each do |l|
          year = l.split('/')[1]
          count = Event.live.by_year(Time.parse(l)).size
          text = "#{year} (#{count})"
          html << "<li>"
          html << link_to(text, refinery.calendar_archive_path(:year => year))
          html << "</li>"
        end
        html << '</ul>'
        html.html_safe
      end

    end
  end
end
