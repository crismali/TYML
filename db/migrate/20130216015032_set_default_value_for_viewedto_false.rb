class SetDefaultValueForViewedtoFalse < ActiveRecord::Migration
  def up
     change_column :tymls, :viewed, :boolean, :default => false
  end

  def down
  end
end
