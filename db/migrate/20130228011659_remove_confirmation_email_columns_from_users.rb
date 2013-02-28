class RemoveConfirmationEmailColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column(:users, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email)
  end

  def down
  end
end
