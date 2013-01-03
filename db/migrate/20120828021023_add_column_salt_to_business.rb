class AddColumnSaltToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :salt, :string

  end
end
