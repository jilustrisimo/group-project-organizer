class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]
  before_action :check_if_team_member, except: %i[index new create]

  def index
    @projects = Project.ordered
    respond_to do |f|
      f.html
      f.json { render json: @projects}
    end
  end

  def show
    respond_to do |f|
      f.html
      f.json { render json: @project}
    end
  end

  def new
    @project = Project.new
  end

  def edit() end

  def create
    @project = Project.new(project_params)
    @project.team_members << current_user
    notice = 'Project was successfully created.'
    @project.save ? (redirect_to @project, notice: notice) : (render :new)
  end

  def update
    @project.assign_attributes(project_params)
    notice = 'Project was successfully updated.'
    @project.save ? (redirect_to @project, notice: notice) : (render :edit)
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
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
end
