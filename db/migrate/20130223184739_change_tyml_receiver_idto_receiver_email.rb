class ChangeTymlReceiverIdtoReceiverEmail < ActiveRecord::Migration
  def up
    rename_column :tymls, :receiver_id, :receiver_email

    change_column :tymls, :receiver_email, :string
  end

  def down
  end
end
