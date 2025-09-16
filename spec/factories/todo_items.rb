FactoryBot.define do
  factory :todo_item do
    title { "Task" }
    description { "Task description" }
    status { :pending }
    association :todo_list
  end
end