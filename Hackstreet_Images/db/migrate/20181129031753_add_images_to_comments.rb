class AddImagesToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :image, foreign_key: true
  end
end
