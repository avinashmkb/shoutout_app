class AddMcouponHandlingToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :mcoupon, :boolean

  end
end
