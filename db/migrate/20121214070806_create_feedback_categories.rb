class CreateFeedbackCategories < ActiveRecord::Migration
  def change
    create_table :feedback_categories do |t|
      t.integer :feedback_id
      t.integer :category_id
      t.integer :branch_id

      t.timestamps
    end
  end
end
