class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :profile_pic
      t.text :bio
      t.string :location

      t.timestamps
    end
  end
end
