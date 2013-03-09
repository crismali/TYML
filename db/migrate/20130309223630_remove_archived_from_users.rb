class RemoveArchivedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :archived
    add_column :tymls, :archived, :boolean, :default => false
  end
end
