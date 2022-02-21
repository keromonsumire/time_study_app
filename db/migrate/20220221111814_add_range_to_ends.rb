class AddRangeToEnds < ActiveRecord::Migration[5.2]
  def change
    add_column :ends, :range, :integer
  end
end
