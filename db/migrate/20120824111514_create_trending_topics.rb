class CreateTrendingTopics < ActiveRecord::Migration
  def change
    create_table :trending_topics do |t|
      t.string :text
	t.references :sentiment
	t.references :branch
      t.timestamps
    end
  end
end
