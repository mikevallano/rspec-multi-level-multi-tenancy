FactoryGirl.define do
  factory :membership do
    user
    account

    factory :invalid_membership do
      user nil
    end
  end

end
