
FactoryGirl.define do
  factory :user do
    name     "ryuji"
    email    "ryu@email.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
