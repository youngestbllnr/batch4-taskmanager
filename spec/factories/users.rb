FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'password' }
    firstname { 'Test' }
    lastname { 'User' }
  end
end