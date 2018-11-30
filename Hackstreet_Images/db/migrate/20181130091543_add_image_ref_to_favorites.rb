class AddImageRefToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_reference :favorites, :image, foreign_key: true
  end
end
