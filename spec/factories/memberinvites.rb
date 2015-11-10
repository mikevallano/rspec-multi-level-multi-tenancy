FactoryGirl.define do
  factory :memberinvite do
    email { Faker::Internet.email }
    receiver_id 1
    sender_id 2
    memberinvite_token "token3232323"
    account

    factory :invalid_memberinvite do
      email nil
    end

    factory :invalid_email_memberinvite do
      email "test.com"
    end
  end

end
