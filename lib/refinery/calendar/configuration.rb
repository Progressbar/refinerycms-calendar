module Refinery
  module Calendar
    include ActiveSupport::Configurable

    config_accessor :events_per_page, :events_per_dialog, :events_per_admin_index,
                    :categories, :places, :facebook_events,
                    :events_desc_length, :events_tzid, :events_tzname,
                    :html_allowed_tags, :html_allowed_tag_attributes,
                    :refinery_user_can_manage_events, :refinery_user_can_manage_categories, :refinery_user_can_manage_places,
                    :social_buttons, :facebook_link, :twitter_link, :mailinglist_link,
                    :theme, :first_day

    self.categories = true
    self.places = true
    self.facebook_events = false

    self.events_per_page = 14
    self.events_per_dialog = 14
    self.events_per_admin_index = 20
    self.events_desc_length = 120
    self.events_tzid = 'Europe/Central'
    self.events_tzname = 'CET'

    # sanitization
    self.html_allowed_tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p div span table tr td thead tbody tfoot img)
    self.html_allowed_tag_attributes = %w(href title src id class alt)

    # acl
    self.refinery_user_can_manage_events = false
    self.refinery_user_can_manage_categories = false
    self.refinery_user_can_manage_places = true

    # evils
    self.social_buttons = true
    self.facebook_link = 'https://www.facebook.com/progressbar'
    self.twitter_link = 'https://twitter.com/progressbarsk'
    self.mailinglist_link = '#mailing-list'

    # styling
    self.theme = 'default'

    # 0 -> Sunday, 1 -> Monday
    self.first_day = 1
  end
end
