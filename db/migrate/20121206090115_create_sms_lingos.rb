class CreateSmsLingos < ActiveRecord::Migration
  def change
    create_table :sms_lingos do |t|
      t.string :sms_word
      t.string :english_text

      t.timestamps
    end
  end
end
