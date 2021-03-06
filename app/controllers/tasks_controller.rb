class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_project, except: %i[assign index unassign]
  before_action :check_if_team_member, except: %i[assign index unassign]

  def index
    @tasks = current_user.tasks.ordered
  end

  def new
    @task = Task.new
  end

  def edit() end

  def create
    @task = @project.tasks.build(task_params)
    notice = 'Task was successfully created.'
    @task.save ? (render json: @project) : (render :new)
  end

  def update
    @task.assign_attributes(task_params)
    notice = 'Task was successfully updated.'
    if @task.save
      params[:task].include?('completed') ?
      (redirect_to request.env['HTTP_REFERER'], notice: notice) :
      (redirect_to @project, notice: notice)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    notice = 'Task was successfully destroyed.'
    redirect_to request.env['HTTP_REFERER'], notice: notice
  end

  # add task to current_user.tasks
  def assign
    @task = Task.find(params[:task_id])
    current_user.tasks << @task
    notice = "You have successfully assigned yourself to #{@task.title}"
    redirect_to project_path(@task.project), notice: notice
  end

  # remove task from current_user.tasks
  def unassign
    current_user.tasks.where('id = ?', params[:task_id]).update(user_id: nil)
    notice = 'Task successfully unassigned'
    redirect_to request.env['HTTP_REFERER'], notice: notice
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
