class CreateCollapses < ActiveRecord::Migration
  def change
    create_table :collapses do |t|
      t.string :new_name
      t.string :old_name

      t.timestamps
    end
  end
end
