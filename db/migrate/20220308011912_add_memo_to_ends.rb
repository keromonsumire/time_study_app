class AddMemoToEnds < ActiveRecord::Migration[5.2]
  def change
    add_column :ends, :memo, :text
  end
end
