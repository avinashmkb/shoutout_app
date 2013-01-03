class AddStatusToMcoupon < ActiveRecord::Migration
  def change
    add_column :mcoupons, :status, :integer

  end
end
