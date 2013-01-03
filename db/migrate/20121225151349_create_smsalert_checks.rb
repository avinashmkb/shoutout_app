class CreateSmsalertChecks < ActiveRecord::Migration
  def change
    create_table :smsalert_checks do |t|
      t.string :allowed_keyword

      t.timestamps
    end
  end
end
