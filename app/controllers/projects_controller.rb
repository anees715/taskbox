class ProjectsController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@projects = current_user.projects
	end

	def new
		@project = Project.new

	end

	def create
		@project = Project.new(project_params)
		@project.user_id = current_user.id
		if @project.save
			redirect_to project_path(@project), notice: "Successfully created client"
		else
			render action: "new"
		end
	end

	def show
		@project = Project.find(params[:id])
		@task = Task.new
		@incomplete = @project.tasks.where('is_completed = ?', false)
		@completed = @project.tasks.where('is_completed = ?', true)
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(project_params)
			redirect_to projects_path, notice: "Successfull updated"
		else
			render action: "edit"
		end
	end


	def destroy
		@project = current_user.projects.find(params[:id])
		@project.destroy
		redirect_to projects_path, notice: "Successfully destroyed"
	end
	
private

	def project_params
		params[:project].permit(:name, :description, :start_date, :client_id, :status, category_ids: [])
	end
end
