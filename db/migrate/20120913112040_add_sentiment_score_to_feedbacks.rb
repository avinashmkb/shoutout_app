class AddSentimentScoreToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :sentiment_score, :integer , :default=> 0

  end
end
