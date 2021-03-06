class TasksController < ApplicationController


	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to project_path(@task.project_id), notice: "Successfully Saved"
		else
			render action: "new", notice: "Error"
		end
	end

private

def task_params
	params[:task].permit(:title, :project_id, :due_date, :is_completed)
end

end
