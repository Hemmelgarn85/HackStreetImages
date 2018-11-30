class DeleteImagerefFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :imageref
  end
end
