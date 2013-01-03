class CreateCustomMessages < ActiveRecord::Migration
  def change
    create_table :custom_messages do |t|
      t.string :message
      t.string :created_by
	t.references :sentiment
	t.references :branch
	t.references :business
      t.timestamps
    end
  end
end
