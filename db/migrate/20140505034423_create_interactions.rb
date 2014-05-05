class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :downstream
      t.string :upstream
      t.integer :distance
      t.string :contig

      t.timestamps
    end
  end
end
