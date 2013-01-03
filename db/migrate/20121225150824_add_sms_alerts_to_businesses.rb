class AddSmsAlertsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :sms_alerts, :boolean

  end
end
