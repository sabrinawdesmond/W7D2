class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true, index: true
      t.string :password_digest, null: false
      t.string :session_token, index: true, null: false

      t.timestamps
    end
  end
end
