class CreateTymls < ActiveRecord::Migration
  def change
    create_table :tymls do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :url
      t.string :note
      t.boolean :viewed

      t.timestamps
    end
  end
end
