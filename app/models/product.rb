class Product < ActiveRecord::Base

	validates_numericality_of :price, greater_than: 0

	validate :check_projects

	private
	def check_projects
		if self.status != "new"
			errors.add(:status, "is not new")
	end

end
