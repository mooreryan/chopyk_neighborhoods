class CreateSuperfamilyInteractions < ActiveRecord::Migration
  def change
    create_table :superfamily_interactions do |t|
      t.string :downstream
      t.string :upstream
      t.integer :distance
      t.string :contig

      t.timestamps
    end
  end
end
