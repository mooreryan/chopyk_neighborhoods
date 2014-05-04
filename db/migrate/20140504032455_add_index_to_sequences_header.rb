class AddIndexToSequencesHeader < ActiveRecord::Migration
  def change
    add_index :sequences, :header, unique: true
  end
end
