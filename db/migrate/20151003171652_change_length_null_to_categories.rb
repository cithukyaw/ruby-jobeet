class ChangeLengthNullToCategories < ActiveRecord::Migration
  def up
    change_table :categories do |t|
      t.change :name, :string, :limit => 100, :null => false
      t.change :slug, :string, :limit => 100
    end
  end

  def down
    change_table :categories do |t|
      t.change :name, :string, :limit => 255, :null => true
      t.change :slug, :string, :limit => 255
    end
  end
end
