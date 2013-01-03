class CreateConfigtables < ActiveRecord::Migration
  def change
    create_table :configtables do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
