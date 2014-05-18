class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :sequences, :sequence, :contig
  end
end
