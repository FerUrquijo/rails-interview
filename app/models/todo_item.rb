class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :title, :status, :todo_list_id, presence: true
  
  enum :status, { pending: 0, completed: 1 }
end