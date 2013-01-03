class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :contact_person
      t.string :contact_number
      t.string :address_lane1
      t.string :address_lane2
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
