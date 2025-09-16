class CreateTodoItem < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.references :todo_list, null: false
      t.integer :status, null: false, default: 0
      t.text :title, null: false
      t.text :description
      t.timestamps
    end
  end
end
