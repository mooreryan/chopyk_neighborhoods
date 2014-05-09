class RemoveIndexFromCollpasesOldName < ActiveRecord::Migration
  def change
    remove_index :collapses, :old_name
  end
end
