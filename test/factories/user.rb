FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    authenticated { false }
  end
end
