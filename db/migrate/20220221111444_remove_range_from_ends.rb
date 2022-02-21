class RemoveRangeFromEnds < ActiveRecord::Migration[5.2]
  def change
    remove_column :ends, :range, :real
  end
end
