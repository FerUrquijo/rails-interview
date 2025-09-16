require "rails_helper"

RSpec.describe CompleteTodoItemJob, type: :job do
  let!(:todo_list) { create(:todo_list, :with_pending_items, items_count: 1) }
  let!(:todo_item) { todo_list.todo_items.first }
  
  before do
    allow_any_instance_of(CompleteTodoItemJob).to receive(:sleep)
  end

  it "marks the item as completed" do
    described_class.new.perform(todo_item.id)
    expect(todo_item.reload.status).to eq("completed")
  end

  it "broadcasts to the correct Turbo stream" do
    expect(Turbo::StreamsChannel).to receive(:broadcast_replace_to).with(
      todo_list,
      target: ActionView::RecordIdentifier.dom_id(todo_item),
      partial: "todo_items/todo_item",
      locals: { todo_item: todo_item.reload }
    )

    described_class.new.perform(todo_item.id)
  end
end
