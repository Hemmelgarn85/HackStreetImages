class Image < ApplicationRecord
  has_one_attached :image_datafile
  belongs_to :category, optional: true
end
