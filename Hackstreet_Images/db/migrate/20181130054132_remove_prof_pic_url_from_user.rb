class RemoveProfPicUrlFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :prof_pic_url
  end
end
