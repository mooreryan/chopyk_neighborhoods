class AddForeignKeys < ActiveRecord::Migration
  def change
    add_index :superfamily_interactions, :contig
    add_index :orf_infos, :contig

    change_table :superfamily_interactions do |t|
    end

    change_table :orf_infos do |t|
    end
  end
end
