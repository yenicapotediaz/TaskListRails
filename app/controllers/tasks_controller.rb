class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = session[:user_id]
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @task.assign_attributes(task_params)
    if @task.save
      completed(@task)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end


  private

  def task_params
    params.require(:task).permit(:name, :description, :completion_status, :completion_date)
  end

  def find_task
    begin
      @task = @current_user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404", status: :not_found
    end
  end

end

def completed(task)
  if task.completion_status == true
    task.completion_date = Date.today
    task.save
  elsif task.completion_status == false
    task.completion_date = nil
    task.save
  end
  redirect_to tasks_path
end
