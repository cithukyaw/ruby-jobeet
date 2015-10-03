class ChangeLengthNullDefaultToJobs < ActiveRecord::Migration
  def up
    change_table :jobs do |t|
      t.change :type, :string, :limit => 20, :null => false
      t.change :company, :string, :limit => 50, :null => false
      t.change :position, :string, :limit => 100, :null => false
      t.change :description, :text, :null => false
      t.change :how_to_apply, :text, :null => false
      t.change :email, :string, :limit => 100, :null => false
      t.change :is_public, :boolean, :default => false
      t.change :is_activated, :boolean, :default => false
    end
  end

  def down
    change_table :jobs do |t|
      t.change :type, :string, :limit => 255, :null => true
      t.change :company, :string, :limit => 255, :null => true
      t.change :position, :string, :limit => 255, :null => true
      t.change :description, :text, :null => true
      t.change :how_to_apply, :string, :limit => 255, :null => true
      t.change :email, :string, :limit => 255, :null => true
      t.change :is_public, :boolean
      t.change :is_activated, :boolean
    end
  end
end
