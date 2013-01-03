class AddBusinessIdToConfigtables < ActiveRecord::Migration
  def change
    add_column :configtables, :business_id, :integer

  end
end
