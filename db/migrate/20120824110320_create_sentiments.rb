class CreateSentiments < ActiveRecord::Migration
  def change
    create_table :sentiments do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
