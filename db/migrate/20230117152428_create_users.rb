class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null:false
      t.string :user_id, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, [:user_id], unique: true
  end
end
