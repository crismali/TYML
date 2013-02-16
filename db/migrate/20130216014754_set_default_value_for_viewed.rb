class SetDefaultValueForViewed < ActiveRecord::Migration
  def up

    change_column :tymls, :viewed, :boolean, :default => true
  end

  def down
  end
end
