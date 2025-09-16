require "rails_helper"
require "sidekiq/testing"

RSpec.describe CompleteAll, type: :interactor do
  before { Sidekiq::Testing.fake! }

  let(:todo_list) { create(:todo_list, :with_pending_items) }

  it "enqueues an CompleteTodoItemJob for each todo item" do
    expect {
      CompleteAll.call(todo_list_id: todo_list.id)
    }.to change(CompleteTodoItemJob.jobs, :size).by(todo_list.todo_items.count)
  end
end