class AddRangeToEnd < ActiveRecord::Migration[5.2]
  def change
    add_column :ends, :range, :real
  end
end
