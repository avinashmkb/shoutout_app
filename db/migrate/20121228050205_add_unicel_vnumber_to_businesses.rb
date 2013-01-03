class AddUnicelVnumberToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :unicel_vnumber, :string

  end
end
