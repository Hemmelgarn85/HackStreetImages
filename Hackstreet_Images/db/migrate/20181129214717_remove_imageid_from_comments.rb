class RemoveImageidFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :image_id
  end
end
