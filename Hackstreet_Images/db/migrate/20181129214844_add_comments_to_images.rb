class AddCommentsToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :image_id, :integer    
    add_index :comments, :image_id 
  end
end
