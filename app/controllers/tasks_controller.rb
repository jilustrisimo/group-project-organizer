class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_project, except: %i[assign display]

  def show() end

  def new
    @task = Task.new
  end

  def edit() end

  def create
    if @project.tasks.build(task_params).save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update

    @task.assign_attributes(task_params)
    notice = 'Task was successfully updated.'
    @task.save ? (redirect_to @project, notice: notice) : (render :edit)
  end

  def destroy
    @task.destroy
    redirect_to request.env['HTTP_REFERER'], notice: 'Task was successfully destroyed.'
  end

  def assign
    task = Task.find(params[:task_id])
    current_user.tasks << task
    redirect_to project_path(task.project), notice: "You have successfully assigned yourself to #{task.title}"
  end

  def display
    @tasks = current_user.tasks
    render :index
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :due_date, :completed)
  end
end
