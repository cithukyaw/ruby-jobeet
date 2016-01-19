class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :url
      t.string :email
      t.string :token
      t.boolean :is_active

      t.timestamps
    end

    add_index :affiliates, :email, unique: true
  end
end
