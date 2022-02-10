class AddStartToEnds < ActiveRecord::Migration[5.2]
  def change
    add_reference :ends, :start, foreign_key: true
  end
end
