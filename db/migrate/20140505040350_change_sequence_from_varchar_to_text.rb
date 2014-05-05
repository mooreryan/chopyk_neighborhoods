class ChangeSequenceFromVarcharToText < ActiveRecord::Migration
  # see http://stackoverflow.com/questions/8694273/
  # changing-a-column-type-to-longer-strings-in-rails for details
  def up
    change_column :sequences, :sequence, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :your_table, :your_column, :string
  end
end
