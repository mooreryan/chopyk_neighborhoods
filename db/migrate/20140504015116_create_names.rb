class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :contig_name
      t.string :orf_name

      t.timestamps
    end
  end
end
