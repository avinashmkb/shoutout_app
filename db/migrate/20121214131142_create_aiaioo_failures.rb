class CreateAiaiooFailures < ActiveRecord::Migration
  def change
    create_table :aiaioo_failures do |t|
      t.string :source_number
      t.string :text
      t.integer :retried

      t.timestamps
    end
  end
end
