FactoryBot.define do
  factory :user do
    name {"name"}
    email {"email@123!"}
    password {"password"}
    password_confirmation { "password" }
  end


end