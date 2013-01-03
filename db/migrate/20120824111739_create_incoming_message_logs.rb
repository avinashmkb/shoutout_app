class CreateIncomingMessageLogs < ActiveRecord::Migration
  def change
    create_table :incoming_message_logs do |t|
      t.string :message
      t.string :mobile_number

      t.timestamps
    end
  end
end
