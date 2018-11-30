class AddFavoritesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :user_id, :integer    
    add_index :favorites, :user_id 
  end
end
