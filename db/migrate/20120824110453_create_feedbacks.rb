class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :message
	t.references :user
	t.references :sentiment
	t.references :branch
      t.timestamps
    end
  end
end
