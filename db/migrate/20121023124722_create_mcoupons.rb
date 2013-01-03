class CreateMcoupons < ActiveRecord::Migration
  def change
    create_table :mcoupons do |t|
      t.string :coupon_id
      t.string :coupon_code

      t.timestamps
    end
  end
end
