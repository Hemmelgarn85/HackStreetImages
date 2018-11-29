class AddBioAndProfPicToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :string
    add_column :users, :prof_pic_url, :string
  end
end
