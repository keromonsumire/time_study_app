class AddEndToStarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :starts, :end, foreign_key: true
  end
end
