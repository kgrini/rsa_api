FactoryGirl.define do
  factory :task do
    tag 'ABC'
    deadline_time DateTime.new
  end
end