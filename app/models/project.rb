class Project < ActiveRecord::Base

	has_many :project_categories
	has_many :categories, through: :project_categories
	has_many :tasks

	belongs_to :client
	belongs_to :user


	validates_presence_of :name, :description, :client_id , :status
	validates_numericality_of :client_id 
	validates_length_of :description, minimum:10


=begin
	#when arguments are passed for a method we use : before, and for options
	#for the method we pass : after, the values for options we pass : before

	#custom validations
	#this validations get invoked only at the timeof creating new record and not updating
	validate :check_status_on_create, on: :create
	validate :check_date, on: :create

	private

	def check_status_on_create
		if self.status != "new"
			errors.add(:status, "is not new")
		end
	end

	def check_date
		if self.start_date.nil?
		if self.start_date > (Date.today + 7.days))
			errors.add(:date, "is invalid")
		end
	end
	end


	validate :check_projects
	validate :check_uniqueness

	def check_projects
		count = Project.where('client_id = ?', self.client_id).count
		if count > 2
			errors.add(:client_id, "error")
		end
	end

	def check_uniqueness
		if Project.pluck('name').include?(self.name)
		errors.add(:name, "Must Be unique")
		end
	end	
=end
def completed_tasks
	self.tasks.where('is_completed = ?', true)
end

def incompleted_tasks
	self.tasks.where('is_completed = ?', false)
end

def overdue_tasks
	self.tasks.where('is_completed = ? AND project_id =?', true, self.id)
end

end
