FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password' }
    language { 'English' }
    firstname { 'Test' }
    lastname { 'User' }

    trait :filipino do
      language { 'Filipino' }
    end
  end
end