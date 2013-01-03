class RemoveContactNumber < ActiveRecord::Migration
  def up
      remove_column :businesses, :contact_number
  end

  def down
  end
end
