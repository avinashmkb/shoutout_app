class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :created_by
	t.references :business
      t.timestamps
    end
  end
end
