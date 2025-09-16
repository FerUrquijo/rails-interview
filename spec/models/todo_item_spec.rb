require "rails_helper"

RSpec.describe TodoItem, type: :model do
  it { should belong_to(:todo_list) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:todo_list_id) }

  it {should define_enum_for(:status).with_values(pending: 0, completed: 1)}
end