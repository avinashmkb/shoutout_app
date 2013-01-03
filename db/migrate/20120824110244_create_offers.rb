class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :message
      t.date :start_date
      t.date :end_date
      t.string :created_by
	t.references :sentiment
	t.references :branch
      t.timestamps
    end
  end
end
