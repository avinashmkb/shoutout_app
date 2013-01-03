class AddSentimentScoreToTrendingTopics < ActiveRecord::Migration
  def change
    add_column :trending_topics, :sentiment_score, :integer

  end
end
