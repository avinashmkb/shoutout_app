class CreateSentimentOverrides < ActiveRecord::Migration
  def change
    create_table :sentiment_overrides do |t|
      t.string :text
      t.string :sentiment_id

      t.timestamps
    end
  end
end
