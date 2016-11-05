class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :name #.string upto 255 characters
    	t.text :description #dynamic length
    	t.date :start_date
    	t.integer :client_id #FK will always be integer
    	t.string :status

      t.timestamps null: false
    end
  end
end
