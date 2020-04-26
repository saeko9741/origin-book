FactoryBot.define do
  factory :user do
    name {"test1"}
    email {"email@123!"}
    password {"111111"}
    password_confirmation { "111111" }
  end


end