FactoryBot.define do
  factory :category do
    user { User.new }
    icon { "😀" }
    title { "Sample Category" }
    description { "This is a sample category." }
  end
end