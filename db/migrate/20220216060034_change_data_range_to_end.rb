class ChangeDataRangeToEnd < ActiveRecord::Migration[5.2]
  def change
    change_column :ends, :range, :integer
  end
end
