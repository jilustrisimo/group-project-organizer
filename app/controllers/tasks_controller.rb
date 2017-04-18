class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_project

  def show() end

  def new
    @task = Task.new
  end

  def edit() end

  def create
    @task = Task.new(task_params)

    if @project.tasks.build(@task_params).save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update

    @task.assign_attributes(task_params)
    notice = 'Task was successfully updated.'
    @task.save ? (redirect_to project_task_path, notice: notice) : (render :edit)
  end

  def destroy
    @task.destroy
    # respond_to do |format|
    #   format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
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
