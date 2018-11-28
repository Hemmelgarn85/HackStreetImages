class AddUserRefToImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :user, foreign_key: true
    add_index :images, [:user_id, :created_at]
  end
end
