class ChangeDataRangeToEnds < ActiveRecord::Migration[5.2]
  def change
    change_column :ends, :range, :real
  end
end
