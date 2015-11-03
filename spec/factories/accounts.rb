FactoryGirl.define do
  factory :account do
    name { Faker::Hacker.ingverb }
    subdomain { Faker::Internet.domain_word}

    factory :invalid_account do
      subdomain nil
    end
  end

end
