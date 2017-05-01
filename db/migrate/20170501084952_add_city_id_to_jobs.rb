class AddCityIdToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :city_id, :integer
  end
end
