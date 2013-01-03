class CreateCategoryKeywords < ActiveRecord::Migration
  def change
    create_table :category_keywords do |t|
      t.string :keyword
      t.string :created_by
	t.references :category
      t.timestamps
    end
  end
end
