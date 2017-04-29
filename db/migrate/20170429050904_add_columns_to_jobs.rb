class AddColumnsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category_id, :string
    add_column :jobs, :—force, :string
  end
end
