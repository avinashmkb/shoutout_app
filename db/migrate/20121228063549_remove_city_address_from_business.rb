class RemoveCityAddressFromBusiness < ActiveRecord::Migration
  def up
     remove_column :businesses, :contact_person,:address_lane1,:address_lane2,:city,:state,:smsalerts_check
  end

  def down
  end
end
