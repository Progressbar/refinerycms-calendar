FactoryGirl.define do
  factory :event, :class => Refinery::Calendar::Event do
    sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
    description "Pozdravujem vas hory lesy, z tej duse pozdravujem vas!"
    draft false
    published_at Time.now
    user_id { Factory(:refinery_user) }
    # start tomorrow on 18:00 until 22:00
    dates [
      Refinery::Calendar::Date.new(:date_time => Time.now.tomorrow.change(:hour => 18, :minute => 0)), 
      Refinery::Calendar::Date.new(:date_time => Time.now.tomorrow.change(:hour => 20, :minute => 0)), 
    ]
    
    factory :event_draft do
      draft true
    end
  end
end
