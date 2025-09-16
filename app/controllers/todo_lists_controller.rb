class TodoListsController < ApplicationController
  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  def show
    @todo_list = TodoList.find(params[:id])
    
    respond_to :html
  end

  def update_all
    CompleteAll.call(todo_list_id: params[:id])
  
    head :ok 
  end
end
