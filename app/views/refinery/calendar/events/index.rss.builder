xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Refinery::Core.site_name
    xml.description Refinery::Core.site_name + ' ' + t('.events')
    xml.link refinery.calendar_root_url

    @events.each do |event|
      xml.item do
        xml.title event.title
        xml.description simple_format(strip_tags event.description)

        xml.start_date event.start_date.to_s(:rfc822)
        xml.end_date event.end_date.to_s(:rfc822)

        xml.link refinery.calendar_event_url(event)
        xml.pubDate event.published_at.to_s(:rfc822)
      end
    end
  end
end