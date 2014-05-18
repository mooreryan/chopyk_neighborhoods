class RemoveSequenceIdFromSomeModels < ActiveRecord::Migration
  def change
    remove_column :superfamily_interactions, :sequence_id
    remove_column :interactions, :sequence_id
    remove_column :orf_infos, :sequence_id

  end
end
