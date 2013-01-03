class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :address_lane1
      t.string :address_lane2
      t.string :city
      t.string :state
      t.string :country
      t.string :created_by
      t.references :business
      t.timestamps
    end
  end
end
