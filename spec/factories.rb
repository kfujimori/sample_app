FactoryGirl.define do
  factory :user do
    # name     "Michael Hartl"
    # email    "michael@example.com"
    # password "foobar"
    # password_confirmation "foobar"
    sequence(:name)  {|n| "Person #{n}"}
    sequence(:email) {|n| "Person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
        admin true
    end
  end
end