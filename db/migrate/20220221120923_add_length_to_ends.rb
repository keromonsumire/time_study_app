class AddLengthToEnds < ActiveRecord::Migration[5.2]
  def change
    add_column :ends, :length, :real
  end
end
