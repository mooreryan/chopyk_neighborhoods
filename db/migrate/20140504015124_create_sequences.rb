class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.string :header
      t.string :sequence

      t.timestamps
    end
  end
end
