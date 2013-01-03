class CreateFeedbackTopic < ActiveRecord::Migration
  def up
    create_table :feedback_topics, :id => false do |t|
        t.references :feedback
        t.references :trendingtopic
        t.references :branch
    end
  end

  def down
  	delete_table :feedback_topics
  end
end
