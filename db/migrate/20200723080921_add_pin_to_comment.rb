class AddPinToComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :pin, foreign_key: true
  end
end
