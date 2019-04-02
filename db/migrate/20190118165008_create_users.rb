class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
<<<<<<< HEAD
      t.string :slug
=======
>>>>>>> e498e2874dc1c65b9572a3cc6e96705b3cab98ce
    end
  end
end
