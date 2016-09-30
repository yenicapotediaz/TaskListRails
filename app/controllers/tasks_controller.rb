class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :completion_status, :completion_date)
  end

end
