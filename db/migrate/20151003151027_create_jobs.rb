class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :type
      t.string :company
      t.string :logo
      t.string :url
      t.string :position
      t.string :location
      t.text :description
      t.string :how_to_apply
      t.string :token
      t.boolean :is_public
      t.boolean :is_activated
      t.string :email
      t.datetime :expires_at
      t.references :category, index: true

      t.timestamps
    end
  end
end
