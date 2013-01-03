class AddRefNumberToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :ref_num, :string

  end
end
