class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    #Has to be called password_digest for the password to work
    add_column :users, :password_digest, :string
  end
end
