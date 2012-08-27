FactoryGirl.define do
  factory :event, :class => Refinery::Calendar::Event do
    sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
    description "Pozdravujem vas hory lesy, z tej duse pozdravujem vas!"
    draft false
    published_at Time.now
    user_id { Factory(:refinery_user) }
    # start tomorrow on 18:00 until 22:00
    start_date Time.now.tomorrow.beginning_of_day + (60 * 60 * 18)
    end_date Time.now.tomorrow.beginning_of_day + (60 * 60 * 22)
    
    factory :event_draft do
      draft true
    end
  end
end
