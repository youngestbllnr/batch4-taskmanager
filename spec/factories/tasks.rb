FactoryBot.define do
  factory :task do
    category { Category.new }
    title { "Sample Task" }
    description { "This is a sample task." }
    due_date { Date.current + 1.week }

    trait :today do
      due_date { Date.today }
    end
    
    trait :checked do
      is_checked { true }
    end

    trait :unchecked do
      is_checked { false }
    end
  end
end