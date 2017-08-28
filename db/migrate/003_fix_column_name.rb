class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :passwords, :password
  end
end