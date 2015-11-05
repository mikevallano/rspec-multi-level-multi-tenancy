FactoryGirl.define do
  factory :post do
    name { Faker::Hacker.adjective }
    description { Faker::Hacker.say_something_smart }
    project

    factory :invalid_post do
      name nil
    end
  end

end
