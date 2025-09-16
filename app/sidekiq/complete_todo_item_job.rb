class CompleteTodoItemJob
  include Sidekiq::Job
  include ActionView::RecordIdentifier 

  def perform(item_id)
    item = TodoItem.find(item_id)
    todo_list = item.todo_list
    item.update!(status: :completed)
    sleep 3


    puts "ID: #{dom_id(item)}"
    
    Turbo::StreamsChannel.broadcast_replace_to(
      todo_list,
      target: dom_id(item),
      partial: "todo_items/todo_item",
      locals: { todo_item: item }
    )
  end
end