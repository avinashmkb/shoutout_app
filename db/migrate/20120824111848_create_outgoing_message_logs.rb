class CreateOutgoingMessageLogs < ActiveRecord::Migration
  def change
    create_table :outgoing_message_logs do |t|
      t.string :message
      t.string :destination_mobile_number
      t.string :message_status
	t.references :user
      t.timestamps
    end
  end
end
