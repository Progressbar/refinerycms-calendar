module Refinery
  module Calendar
    include ActiveSupport::Configurable

    config_accessor :events_per_dialog, :events_per_admin_index

    config_accessor :categories, :places
    config_accessor :facebook_events

    config_accessor :events_desc_length, :events_timezone

    # sanitization 
    config_accessor :allowed_tags, :allowed_tag_attributes

    self.categories = true
    self.places = true
    self.facebook_events = false

    self.events_per_dialog = 14
    self.events_per_admin_index = 20
    self.events_desc_length = 120
    self.events_timezone = 'Europe/Central'

    self.allowed_tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p div span table tr td thead tbody tfoot img)
    self.allowed_tag_attributes = %w(href title src id class alt)
  end
end
