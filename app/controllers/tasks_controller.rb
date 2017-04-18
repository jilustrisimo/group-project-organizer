class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    # respond_to do |format|
    #   if @task.save
    #     format.html { redirect_to @task, notice: 'Task was successfully created.' }
    #     format.json { render :show, status: :created, location: @task }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @task.errors, status: :unprocessable_entity }
    #   end
    # end
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
