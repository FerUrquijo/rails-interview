class CompleteAll
  include Interactor

  def call
    todo_list = TodoList.find(context.todo_list_id)

    todo_list.todo_items.find_each do |item|
      CompleteTodoItemJob.perform_async(item.id)
    end
  end
end