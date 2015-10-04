class FixColumnNameJobs < ActiveRecord::Migration
  def up
    rename_column :jobs, :type, :employment_type
  end

  def down
    rename_column :jobs, :employment_type, :type
  end
end
