module Api
  class TodoItemsController < Api::ApiController
    before_action :set_todo_list
    before_action :set_todo_item, only: [:destroy, :show, :update]
    
    def create
      @todo_item = @todo_list.todo_items.create(todo_item_params)
  
      respond_to :json
    end

    def show
      respond_to :json
    end

    def index
      @todo_items = @todo_list.todo_items

      respond_to :json
    end

    def destroy
      @todo_item.destroy

      respond_to :json
    end

    def update
      @todo_item.update(todo_item_params)

      respond_to :json
    end

  private

    def todo_item_params
      params.require(:todo_item).permit(:description, :title, :status)
    end

    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end
  end
end