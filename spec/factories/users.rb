FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    account { FactoryGirl.create(:account) }

    factory :invalid_user do
      email nil
    end
  end

end
