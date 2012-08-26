
FactoryGirl.define do
  factory :place, :class => Refinery::Calendar::Place do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

