class AddSmsalertsCheckToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :smsalerts_check, :boolean

  end
end
