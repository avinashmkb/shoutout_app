class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.string :mobile_number
	t.references :business
	t.references :branch
      t.timestamps
    end
  end
end
