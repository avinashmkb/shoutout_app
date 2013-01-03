class AddBusinessIdToMcoupons < ActiveRecord::Migration
  def change
    add_column :mcoupons, :business_id, :integer

  end
end
