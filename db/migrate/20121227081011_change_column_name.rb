class ChangeColumnName < ActiveRecord::Migration
  def up
       rename_column :businesses, :contact_person, :unicel_vnumber
  end

  def down
  end
end
