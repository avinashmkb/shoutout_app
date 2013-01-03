class RenameUnicel < ActiveRecord::Migration
  def up
       rename_column :businesses,:unicel_vnumber, :contact_person
  end

  def down
  end
end
