FactoryBot.define do
  factory :todo_list do
    name { "My Todo List" }

    trait :with_pending_items do
      transient do
        items_count { 3 }
      end

      after(:create) do |todo_list, evaluator|
        create_list(:todo_item, evaluator.items_count, status: :pending, todo_list: todo_list)
      end
    end
  end
end