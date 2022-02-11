class AddTimeToEnds < ActiveRecord::Migration[5.2]
  def change
    add_column :ends, :time, :datetime
  end
end
