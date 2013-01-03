class AddColumnToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :login_id, :string

    add_column :businesses, :hashed_password, :string

  end
end
