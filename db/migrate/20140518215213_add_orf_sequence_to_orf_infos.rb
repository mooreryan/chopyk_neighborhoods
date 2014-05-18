class AddOrfSequenceToOrfInfos < ActiveRecord::Migration
  def change
    add_column :orf_infos, :orf_sequence, :text
  end
end
