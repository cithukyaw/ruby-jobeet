class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :url
      t.string :email
      t.string :token
      t.boolean :is_active

      t.timestamps
    end
  end
end
