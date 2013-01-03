class CreateFeedbackTopics < ActiveRecord::Migration
  def change
    create_table :feedback_topics do |t|
      t.integer :feedback_id
      t.integer :trendingtopic_id
      t.integer :branch_id

      t.timestamps
    end
  end
end
