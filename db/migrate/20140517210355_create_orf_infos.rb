class CreateOrfInfos < ActiveRecord::Migration
  def change
    create_table :orf_infos do |t|
      t.string :name
      t.string :superfam
      t.string :contig

      t.timestamps
    end
  end
end
