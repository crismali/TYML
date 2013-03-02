class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :tyml_id
      t.string :comment_text

      t.timestamps
    end
  end
end
