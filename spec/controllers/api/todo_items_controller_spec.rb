require 'rails_helper'

describe Api::TodoItemsController do
  render_views

  let!(:todo_list) { TodoList.create(name: "My List") }
  let!(:todo_item) { todo_list.todo_items.create(title: "Task 1", description: "Desc", status: :pending) }

  describe 'GET index' do
    include_context "API format check", :get, :index, todo_list_id: -> { todo_list.id }

    it 'returns all todo items in JSON' do
      get :index, params: { todo_list_id: todo_list.id }, format: :json

      expect(response.status).to eq(200)

      items = JSON.parse(response.body)
      expect(items.count).to eq(1)
      expect(items[0].keys).to match_array(['id', 'title', 'description', 'status', 'todo_list_id', 'created_at'])
    end
  end

  describe 'GET show' do
    include_context "API format check", :get, :show, todo_list_id: -> { todo_list.id }, id: -> { todo_item.id }

    it 'returns a specific todo item in JSON' do
      get :show, params: { todo_list_id: todo_list.id, id: todo_item.id }, format: :json

      expect(response.status).to eq(200)

      item = JSON.parse(response.body)
      aggregate_failures do
        expect(item['id']).to eq(todo_item.id)
        expect(item['title']).to eq(todo_item.title)
        expect(item['description']).to eq(todo_item.description)
        expect(item['status']).to eq(todo_item.status)
      end
    end
  end

  describe 'POST create' do
    include_context "API format check", :post, :create, todo_list_id: -> { todo_list.id }

    it 'creates a new todo item' do
      expect {
        post :create, params: { todo_list_id: todo_list.id, todo_item: { title: "New Task", description: "Desc", status: "pending" } }, format: :json
      }.to change { todo_list.todo_items.count }.by(1)

      expect(response.status).to eq(200)
      item = JSON.parse(response.body)
      expect(item['title']).to eq("New Task")
    end
  end

  describe 'PATCH update' do
    include_context "API format check", :patch, :update, todo_list_id: -> { todo_list.id }, id: -> { todo_item.id }

    it 'updates the todo item' do
      patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { status: "completed" } }, format: :json

      expect(response.status).to eq(200)
      expect(todo_item.reload.status).to eq("completed")
    end
  end

  describe 'DELETE destroy' do
    include_context "API format check", :delete, :destroy, todo_list_id: -> { todo_list.id }, id: -> { todo_item.id }

    it 'deletes the todo item' do
      expect {
        delete :destroy, params: { todo_list_id: todo_list.id, id: todo_item.id }, format: :json
      }.to change { todo_list.todo_items.count }.by(-1)

      expect(response.status).to eq(200)
    end
  end
end