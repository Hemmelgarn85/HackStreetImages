class Image < ApplicationRecord
  has_one_attached :image_datafile
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  enum privacy_level: { anon_public: 0, anon_private: 1, signed_in_private: 2, signed_in_public: 3 }
end