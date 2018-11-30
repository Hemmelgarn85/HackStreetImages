class AddPrivacyLevelToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :privacy_level, :integer
  end
end
