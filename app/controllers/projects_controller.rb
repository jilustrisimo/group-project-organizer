class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show() end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.project_members << current_user
    notice = 'Project was successfully created.'
    @project.save ? (redirect_to @project, notice: notice) : (render :new)
  end

  def update
    @project.assign_attributes(project_params)
    notice = 'Project was successfully updated.'
    @project.save ? (redirect_to @project, notice: notice) : (render :edit)
  end

  def destroy
    if check_if_team_member
      @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    else
      flash[:error] = 'Only a project member can delete a project'
      redirect_to projects_path
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title,
                                    :description,
                                    :due_date,
                                    :completed,
                                    tasks_attributes:
                                    %i[id title content due_date completed])
  end

  def check_if_team_member
    @project.team_members.include?(current_user)
  end
end
