class CreateJoinTableCategoryAffiliate < ActiveRecord::Migration
  def change
    create_join_table :categories, :affiliates do |t|
      t.index [:category_id, :affiliate_id]
      t.index [:affiliate_id, :category_id]
    end
  end
end
