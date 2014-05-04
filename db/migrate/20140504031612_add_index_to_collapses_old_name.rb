class AddIndexToCollapsesOldName < ActiveRecord::Migration
  def change
    add_index :collapses, :old_name, unique: true
  end
end
