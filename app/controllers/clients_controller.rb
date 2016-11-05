class ClientsController < ApplicationController

	before_action :authenticate_user!

	def index
		@clients = current_user.clients
	end

	def new
		@client = Client.new
	end

	def create
		@client = Client.new(client_params)
		@client.user_id = current_user.id
		if @client.save #passes validation - clients_path returns "/clients"
			redirect_to clients_path, notice: "Successfully created client"
		else #display error messages
			render action: "new"
		end
	end

	def show
	begin
		@client = current_user.clients.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		redirect_to clients_path, notice: "Record Not found"
	end
		@project_clients = Project.where('client_id = ?', @client.id)
	end

	def edit
	begin
		@client = current_user.clients.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		redirect_to clients_path, notice: "Record Not found"
	end
	end

	def update
		@client = current_user.clients.find(params[:id])
		if @client.update_attributes(client_params)
			redirect_to client_path(@client), notice: "Successfully updated"
		else
			render action: "edit"
		end
	end


private

def client_params
	params[:client].permit(:name,:mobile,:website,:company,:email)
end

end
