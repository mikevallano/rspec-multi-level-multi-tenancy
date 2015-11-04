FactoryGirl.define do
  factory :project do
    name { Faker::Hacker.ingverb }
    description { Faker::Hacker.ingverb }
    account

    factory :invalid_project do
      name nil
    end
  end

end
