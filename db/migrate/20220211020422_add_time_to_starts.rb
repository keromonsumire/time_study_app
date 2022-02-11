class AddTimeToStarts < ActiveRecord::Migration[5.2]
  def change
    add_column :starts, :time, :datetime
  end
end
