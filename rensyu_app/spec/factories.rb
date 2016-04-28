FactoryGirl.define do
  factory :user do
    name      "honda ryuji"
    email     "ryu@sample.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end
